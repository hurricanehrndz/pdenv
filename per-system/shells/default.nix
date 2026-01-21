{ ... }:
{
  perSystem =
    {
      config,
      pkgs,
      self',
      ...
    }:
    {
      devshells.default = {
        name = "Personal development environment";
        packages = with pkgs; [
          local.pdenv
        ];
        commands = [
          {
            category = "editors";
            name = "pdenv";
            command = "${self'.packages.pdenv}/bin/nvim";
            help = "personalized neovim instance";
          }
        ];

      };
    };
}
