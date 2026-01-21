{ ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      devshells.default =
        let
          pkgWithCategory = category: package: { inherit package category; };
        in
        {
          name = "Personal development environment";
          commands = with pkgs; [
            (pkgWithCategory "nix cache" cachix)
            {
              category = "editors";
              name = "pdenv";
              command = "${pkgs.local.pdenv}/bin/nvim";
              help = "personalized neovim instance";
            }
          ];

        };
    };
}
