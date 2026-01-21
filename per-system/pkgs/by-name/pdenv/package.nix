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
  baseNeovim =
    let
      inherit (inputs) opencode-nvim-src nvim-treesitter-src;
      neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
        withRuby = false;
        withPython3 = false;
        viAlias = false;
        vimAlias = false;
        plugins = import ./plugins.nix {
          inherit
            pkgs
            opencode-nvim-src
            nvim-treesitter-src
            ;
        };
        wrapRc = false;
      };
      wrapperArgs = lib.escapeShellArgs (
        neovimConfig.wrapperArgs
        ++ [
          "--suffix"
          "PATH"
          ":"
          "${extraPackagesBinPath}"
        ]
      );
    in
    pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // { inherit wrapperArgs; });

  # Separate config derivation
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

  # ext = inputs.nix-vscode-extensions.extensions.${system};
  # codelldb = ext.vscode-marketplace.vadimcn.vscode-lldb;
  # debugserverPath = "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  nvimCmd = "${baseNeovim}/bin/nvim --cmd \"set rtp^=${nvimConfig}\" -u \"${nvimConfig}/init.lua\"";
in
symlinkJoin {
  name = "pdenv";
  paths = [
    (writeShellScriptBin "nvim" ''exec ${nvimCmd} "$@"'')
    (writeShellScriptBin "v" ''exec ${nvimCmd} "$@"'')
    (writeShellScriptBin "vi" ''exec ${nvimCmd} "$@"'')
    (writeShellScriptBin "vim" ''exec ${nvimCmd} "$@"'')
    (writeShellScriptBin "nvim-minimal" ''exec ${baseNeovim}/bin/nvim --clean "$@"'')
  ];
}
