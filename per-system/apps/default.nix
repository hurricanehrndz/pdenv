{ ... }:
{
  perSystem =
    {
      config,
      pkgs,
      self',
      inputs',
      lib,
      ...
    }:
    {
      apps = {
        pdenv = {
          type = "app";
          program = "${pkgs.local.pdenv}/bin/nvim";
        };
        default = self'.apps.pdenv;
      };
    };
}
