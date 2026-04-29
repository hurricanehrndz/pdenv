{
  inputs,
  lib,
  pkgs,
  symlinkJoin,
  writeShellScriptBin,
  ...
}:
let
  nvimPython = pkgs.python3.withPackages (
    ps: with ps; [
      debugpy
      flake8
    ]
  );
  extraPackages = import ./extraPackages.nix { inherit pkgs nvimPython; };
  extraPackagesBinPath = "${lib.makeBinPath extraPackages}";

  nvimDict = pkgs.stdenv.mkDerivation {
    name = "nvimDict";
    dontUnpack = true;
    buildInputs = with pkgs; [ (aspellWithDicts (d: [ d.en ])) ];
    installPhase = ''
      mkdir -p $out/
      aspell -d en dump master | aspell -l en expand > $out/en.dict
    '';
  };

  # This is your base neovim - only rebuilds when plugins change
  plugins = import ./plugins.nix {
    inherit
      inputs
      pkgs
      ;
  };

  commonWrapperArgs = [
    "--suffix"
    "PATH"
    ":"
    "${extraPackagesBinPath}"
  ];

  baseNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    withRuby = false;
    withPython3 = false;
    viAlias = false;
    vimAlias = false;
    inherit plugins;
    wrapRc = false;
    wrapperArgs = commonWrapperArgs;
  };

  nvimConfig = pkgs.stdenv.mkDerivation {
    name = "nvim-config";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
      mkdir -p $out/lua/hrndz/generated

      # Create generated config
      cat > $out/lua/hrndz/generated/init.lua << 'EOF'
      local M = {}
      M.run = function ()
        -- Global vars
        vim.g.nix_dap_python = "${nvimPython}/bin/python"
        vim.g.user_provided_dict = "${nvimDict}/en.dict"
      end
      return M
      EOF
    '';
  };

  configuredNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    withRuby = false;
    withPython3 = false;
    viAlias = false;
    vimAlias = false;
    inherit plugins;
    wrapRc = true;
    luaRcContent = ''
      vim.opt.runtimepath:prepend("${nvimConfig}")
      dofile("${nvimConfig}/init.lua")
    '';
    wrapperArgs = commonWrapperArgs;
  };

  # ext = inputs.nix-vscode-extensions.extensions.${system};
  # codelldb = ext.vscode-marketplace.vadimcn.vscode-lldb;
  # debugserverPath = "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
in
symlinkJoin {
  name = "pdenv";
  paths = [
    (writeShellScriptBin "nvim" ''exec ${configuredNeovim}/bin/nvim "$@"'')
    (writeShellScriptBin "v" ''exec ${configuredNeovim}/bin/nvim "$@"'')
    (writeShellScriptBin "vi" ''exec ${configuredNeovim}/bin/nvim "$@"'')
    (writeShellScriptBin "vim" ''exec ${configuredNeovim}/bin/nvim "$@"'')
    (writeShellScriptBin "nvim-minimal" ''exec ${baseNeovim}/bin/nvim --clean "$@"'')
  ];
}
