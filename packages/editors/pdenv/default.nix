{
  inputs,
  inputs',
  lib,
  pkgs,
  packages,
  system,
  ...
}: let
  nvimPython = pkgs.python3.withPackages (ps: with ps; [debugpy flake8]);
  extraPackages = import ./extraPackages.nix {inherit pkgs packages nvimPython inputs system;};
  extraPackagesBinPath = "${lib.makeBinPath extraPackages}";

  nvimDict = pkgs.stdenv.mkDerivation rec {
    name = "nvimDict";
    dontUnpack = true;
    buildInputs = with pkgs; [(aspellWithDicts (d: [d.en]))];
    installPhase = ''
      mkdir -p $out/
      aspell -d en dump master | aspell -l en expand > $out/en.dict
    '';
  };

  # This is your base neovim - only rebuilds when plugins change
  baseNeovim = let
    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      withRuby = false;
      withPython3 = false;
      viAlias = false;
      vimAlias = false;
      plugins = import ./plugins.nix {inherit pkgs packages inputs inputs' nvimPython;};
      wrapRc = false;
    };
    wrapperArgs = lib.escapeShellArgs (neovimConfig.wrapperArgs
      ++ [
        "--suffix"
        "PATH"
        ":"
        "${extraPackagesBinPath}"
      ]);
  in
    pkgs.wrapNeovimUnstable inputs'.neovim-flake.packages.default (neovimConfig // {inherit wrapperArgs;});

  # Separate config derivation
  nvimConfig = pkgs.stdenv.mkDerivation rec {
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
        vim.g.nix_dap_codelldb  = "${debugserverPath}"
      end
      return M
      EOF
    '';
  };

  ext = inputs.nix-vscode-extensions.extensions.${system};
  codelldb = ext.vscode-marketplace.vadimcn.vscode-lldb;
  debugserverPath = "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  nvimCmd = "${baseNeovim}/bin/nvim --cmd \"set rtp^=${nvimConfig}\" -u \"${nvimConfig}/init.lua\"";
in
  pkgs.symlinkJoin {
    name = "nvim";
    paths = [
      (pkgs.writeShellScriptBin "nvim" ''exec ${nvimCmd} "$@"'')
      (pkgs.writeShellScriptBin "vi" ''exec ${nvimCmd} "$@"'')
      (pkgs.writeShellScriptBin "vim" ''exec ${nvimCmd} "$@"'')
      (pkgs.writeShellScriptBin "nvim-minimal" ''exec ${baseNeovim}/bin/nvim --clean "$@"'')
    ];
  }
