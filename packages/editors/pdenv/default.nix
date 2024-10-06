{ inputs
, lib
, pkgs
, packages
, ...
}:
let
  nvimPython = pkgs.python3.withPackages (ps: with ps; [ debugpy flake8 ]);
  extraPackages = import ./extraPackages.nix { inherit pkgs packages nvimPython; };
  extraPackagesBinPath = "${lib.makeBinPath extraPackages}";
  nvimDict = pkgs.stdenv.mkDerivation rec {
    name = "nvimDict";
    dontUnpack = true;
    buildInputs = with pkgs; [ (aspellWithDicts (d: [ d.en ])) ];
    installPhase = ''
      mkdir -p $out/
      aspell -d en dump master | aspell -l en expand > $out/en.dict
    '';
  };
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    withPython3 = false;
    viAlias = true;
    vimAlias = true;
    plugins = import ./plugins.nix { inherit pkgs packages inputs nvimPython; };
    wrapRc = false;
  };
  nvimrc = pkgs.stdenv.mkDerivation rec {
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
          vim.g.user_provided_dict = "${nvimDict}/en.dict"
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
    ''--cmd "set rtp^=${nvimrc}"''
    "--add-flags"
    ''--cmd "luafile ${nvimrc}/init.lua"''
  ]);
  LuaConfig = neovimConfig // { inherit wrapperArgs; };
in
# wrap my neovim pkg override
pkgs.wrapNeovimUnstable packages.neovim LuaConfig
