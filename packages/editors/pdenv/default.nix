{
  inputs,
  lib,
  pkgs,
  packages,
  ...
}: let
  nvimPython = pkgs.python3.withPackages (ps: with ps; [debugpy flake8]);
  extraPackages = import ./extraPackages.nix {inherit pkgs packages nvimPython;};
  extraPackagesBinPath = "${lib.makeBinPath extraPackages}";
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    withPython3 = false;
    plugins = import ./plugins.nix {inherit pkgs packages inputs nvimPython;};
    wrapRc = false;
  };
  nvimrc = pkgs.stdenv.mkDerivation {
    name = "nvimrc";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
      cp ${pkgs.writeText "$out/init.lua" ''
        -- Sensible defaults - mine
        require("hrndz.options")

        -- Key mappings
        require("hrndz.keymaps")

        -- Autocmds
        require("hrndz.autocmds")

        -- Plugins
        require("hrndz.plugins")
      ''} $out/init.lua
      cp ${pkgs.writeText "$out/plugins.lua" ''
        -- Generated plugins configs
        ${neovimConfig.neovimRcContent}
      ''} $out/lua/hrndz/plugins/init.lua
    '';
  };
  # convert to string to stop doublbing of args
  wrapperArgs = lib.escapeShellArgs (neovimConfig.wrapperArgs
    ++ [
      "--suffix"
      "PATH"
      ":"
      "${extraPackagesBinPath}"
      "--add-flags"
      ''--cmd "set rtp^=${nvimrc}"''
      "--add-flags"
      ''--cmd "set rtp+=${packages.nvim-treesitter-master}"''
      "--add-flags"
      "-u ${nvimrc}/init.lua"
    ]);
  LuaConfig = neovimConfig // {inherit wrapperArgs;};
in
  pkgs.wrapNeovimUnstable packages.neovim LuaConfig
