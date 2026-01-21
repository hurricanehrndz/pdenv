{ inputs, ... }:
{
  imports = with inputs; [
    # devshell
    devshell.flakeModule

    # nixpkgs
    ./args.nix

    # formatter
    treefmt-nix.flakeModule
    ./formatter.nix
    ./treefmt.nix

    # packages
    ./pkgs

    # apps
    ./apps

    # define shells
    ./shells
  ];
}
