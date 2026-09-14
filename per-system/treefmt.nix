{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      treefmt = with pkgs; {
        projectRootFile = "flake.nix";

        programs.nixfmt = {
          enable = lib.meta.availableOn stdenv.buildPlatform nixfmt.compiler;
          package = nixfmt;
        };
        programs.shfmt.enable = true;
        programs.shellcheck.enable = true;
        settings.formatter.shellcheck.options = [
          "-s"
          "bash"
        ];
      };
    };
}
