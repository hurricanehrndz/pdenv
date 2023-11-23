{
  inputs,
  lib,
  pkgs,
  packages,
  neovim,
  ...
}: let
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths =
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.bash
        p.c
        p.comment
        p.cpp
        p.go
        p.gomod
        p.gowork
        p.gosum
        p.hcl
        p.javascript
        p.lua
        p.make
        p.markdown
        p.nix
        p.puppet
        p.python
        p.query
        p.terraform
        p.tsx
        p.typescript
        p.vim
        p.vimdoc
        p.yaml
      ]))
      .dependencies;
  };
  nvimPython = pkgs.python3.withPackages (ps: with ps; [debugpy flake8]);
  extraPackages = import ./extraPackages.nix {inherit pkgs packages nvimPython;};
  extraPackagesBinPath = "${lib.makeBinPath extraPackages}";
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    withPython3 = false;
    viAlias = true;
    vimAlias = true;
    plugins = import ./plugins.nix {inherit pkgs packages inputs nvimPython;};
    wrapRc = false;
  };
  nvimrc = pkgs.stdenv.mkDerivation {
    name = "nvimrc";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
      mkdir -p $out/lua/hrndz/generated
      cp ${pkgs.writeText "$out/init.lua" ''
        local M = {}
        M.run = function ()
          -- Global vars
          vim.g.nix_dap_python = "${nvimPython}/bin/python"
        end

        return M
      ''} $out/lua/hrndz/generated/init.lua
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
      ''--cmd "set rtp^=${treesitter-parsers},${nvimrc}"''
      "--add-flags"
      "-u ${nvimrc}/init.lua"
    ]);
  LuaConfig = neovimConfig // {inherit wrapperArgs;};
in
  pkgs.wrapNeovimUnstable neovim LuaConfig
