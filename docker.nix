{
  name,
  tag,
  rev ? null,
  system ? builtins.currentSystem,
}: let
  flake = builtins.getFlake ("git+file:${builtins.toString ./.}"
    + (
      if !(builtins.isNull rev)
      then "?rev=${rev}&shallow=1"
      else ""
    ));
  n2c = flake.inputs.nix2container.packages.${system}.nix2container;
  inherit (flake.packages.${system}) pdenv neovim;
  mkDocker = {
    pkgs,
    name ? "ghcr.io/hurricanehrndz/pdenv",
    tag ? null,
  }:
    n2c.buildImage {
      inherit name;
      tag = if builtins.isNull tag then neovim.version else tag;
      config = {
        entrypoint = [
          "${pdenv}/bin/nvim"
        ];
      };
      layers = [
        (n2c.buildLayer {deps = [pdenv];})
      ];
    };
in
  mkDocker {
    pkgs = flake.lib.nixpkgs system;
    inherit name tag;
  }
