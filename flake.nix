{
  description = "Personal development env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";

    # neovim
    nixpkgs-pr211321.url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    # see: https://github.com/nix-community/neovim-nightly-overlay/issues/176
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    go-nvim-src.url = "github:ray-x/go.nvim";
    go-nvim-src.flake = false;
    gitsigns-src.url = "github:lewis6991/gitsigns.nvim";
    gitsigns-src.flake = false;
    nvim-colorizer-src.url = "github:NvChad/nvim-colorizer.lua";
    nvim-colorizer-src.flake = false;
    nvim-window-src.url = "gitlab:yorickpeterse/nvim-window";
    nvim-window-src.flake = false;
    nvim-osc52-src.url = "github:ojroques/nvim-osc52";
    nvim-osc52-src.flake = false;
    telescope-nvim-src.url = "github:nvim-telescope/telescope.nvim";
    telescope-nvim-src.flake = false;
    nvim-treesitter-src.url = "github:nvim-treesitter/nvim-treesitter";
    nvim-treesitter-src.flake = false;
    mini-nvim-src.url = "github:echasnovski/mini.nvim";
    mini-nvim-src.flake = false;
    nvim-lspconfig-src.url = "github:neovim/nvim-lspconfig";
    nvim-lspconfig-src.flake = false;
    nvim-retrail-src.url = "github:kaplanz/nvim-retrail";
    nvim-retrail-src.flake = false;
    nvim-guihua-src.url = "github:ray-x/guihua.lua";
    nvim-guihua-src.flake = false;
    swiftformat-src.url = "github:nicklockwood/SwiftFormat?rev=a5d58763da90d8240b2a0f7f2b57da29438a0530";
    swiftformat-src.flake = false;
    swiftlint-src.url = "github:realm/SwiftLint?rev=eb85125a5f293de3d3248af259980c98bc2b1faa";
    swiftlint-src.flake = false;

    # golang support tools
    go-enum-src.url = "github:abice/go-enum";
    go-enum-src.flake = false;
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
        inputs.devenv.flakeModule
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
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.
        devenv.shells.default = {
          name = "Personal DevEnv";

          # https://devenv.sh/reference/options/
          packages = [config.packages.default];

          # enterShell = ''
          #   hello
          # '';
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
