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
  nvimRC = pkgs.stdenv.mkDerivation {
    name = "nvimRC";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp ./* $out/
    '';
  };
in
  pkgs.wrapNeovimUnstable packages.neovim neovimConfig
