{
  pkgs,
  packages,
  ...
}: let
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
    ];
  };
  nvimrc = pkgs.stdenv.mkDerivation {
    name = "nvimRC";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
    '';
  };
  LuaConfig =
    neovimConfig
    // {
      wrapperArgs = neovimConfig.wrapperArgs ++ ["--add-flags" "-u ${nvimrc}/init.lua"];
    };
in
  pkgs.wrapNeovimUnstable packages.neovim LuaConfig
