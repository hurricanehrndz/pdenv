{
  description = "Personal development env";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hurricanehrndz.cachix.org"
      "https://nixpkgs-update.cachix.org/"
      "https://cache.nixos.org "
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hurricanehrndz.cachix.org-1:rKwB3P3FZ0T0Ck1KierCaO5PITp6njsQniYlXPVhFuA="
      "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    extra-experimental-features = "nix-command flakes";
  };

  inputs = {
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs.follows = "nixpkgs-master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";

    # see: https://github.com/nix-community/neovim-nightly-overlay/issues/176
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # golang support tools
    go-enum-src.url = "github:abice/go-enum?ref=v0.5.6";
    go-enum-src.flake = false;
    goimports-reviser-src.url = "github:incu6us/goimports-reviser?ref=v3.3.1";
    goimports-reviser-src.flake = false;
    gomvp-src.url = "github:abenz1267/gomvp";
    gomvp-src.flake = false;
    json-to-struct-src.url = "github:tmc/json-to-struct";
    json-to-struct-src.flake = false;

    # pypi packages
    yamllint-src.url = "github:adrienverge/yamllint";
    yamllint-src.flake = false;
    yamlfixer-src.url = "github:opt-nc/yamlfixer";
    yamlfixer-src.flake = false;
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
        ./packages
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.nixneovimplugins.overlays.default
          ];
        };
        devshells.default = {
          name = "Personal development environment";
          packages = with pkgs; [
            nix
            home-manager
            zsh
            self'.packages.pdenv
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
        apps = {
          pdenv = {
            type = "app";
            program = "${self'.packages.pdenv}/bin/nvim";
          };
          default = self'.apps.pdenv;
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
