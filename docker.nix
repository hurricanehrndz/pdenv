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
  inherit (flake.packages.${system}) pdenv neovim;
  mkDocker = {
    pkgs,
    name ? "ghcr.io/hurricanehrndz/pdenv",
    tag ? null,
  }:
    pkgs.dockerTools.buildImage {
      inherit name;
      tag =
        if builtins.isNull tag
        then neovim.version
        else tag;
      copyToRoot = pkgs.buildEnv {
        name = "tailscale-lb";
        paths = [
          pdenv
        ];
      };
      config = {
        Entrypoint = [ "/bin/nvim" ];
      };
      # layers = [
      #   (n2c.buildLayer {deps = [pdenv];})
      # ];
    };
in
  mkDocker {
    pkgs = flake.lib.nixpkgs system;
    inherit name tag;
  }
