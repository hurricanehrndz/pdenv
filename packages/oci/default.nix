{
  nix2container,
  pdenv,
  ...
}: let
  inherit (nix2container) buildImage buildLayer;
in
  buildImage {
    name = "pdenv";
    config = {
      entrypoint = [
        "${pdenv}/bin/nvim"
      ];
    };
    layers = [
      (buildLayer {deps = [pdenv];})
    ];
  }
