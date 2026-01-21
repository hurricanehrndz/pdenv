{
  name,
  tag,
  rev ? null,
  system ? builtins.currentSystem,
  arch,
}:
let
  flake = builtins.getFlake (
    "git+file:${toString ./.}" + (if !(isNull rev) then "?rev=${rev}&shallow=1" else "")
  );
  inherit (flake.packages.${system}) pdenv neovim;
  nixpkgs = system: import flake.inputs.nixpkgs { inherit system; };
  mkDocker =
    {
      pkgs,
      name ? "ghcr.io/hurricanehrndz/pdenv",
      tag ? null,
      arch,
    }:
    pkgs.dockerTools.buildImage {
      inherit name;
      tag = if isNull tag then neovim.version else tag;
      architecture = if arch == "arm64" then "arm64" else "amd64";
      copyToRoot = pkgs.buildEnv {
        name = "pdenv";
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
  pkgs = nixpkgs system;
  inherit name tag arch;
}
