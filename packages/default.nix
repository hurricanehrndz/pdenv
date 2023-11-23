{inputs, ...}: {
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: let
    inherit (inputs'.neovim-flake.packages) neovim;
  in {
    packages = {
      neovim = pkgs.callPackage ./editors/neovim {inherit neovim;};
      pdenv = pkgs.callPackage ./editors/pdenv {
        inherit (self') packages;
        inherit inputs;
        inherit neovim;
      };
      default = config.packages.pdenv;

      yamlfixer = with pkgs.python3Packages;
        buildPythonApplication {
          name = "yamlfixer";
          src = inputs.yamlfixer-src;
          doCheck = false;
          propagatedBuildInputs = [setuptools yamllint];
        };
      go-enum = pkgs.buildGoModule {
        name = "go-enum";
        src = inputs.go-enum-src;
        vendorSha256 = "sha256-+iQCOUg7rGfOgNvmj+lMLYb4A749hDK/3hexEw9IRmI=";
      };
      goimports-reviser = pkgs.buildGoModule rec {
        name = "goimports-reviser";
        src = inputs.goimports-reviser-src;
        vendorSha256 = "sha256-lyV4HlpzzxYC6OZPGVdNVL2mvTFE9yHO37zZdB/ePBg=";
        excludedPackages = [ "linter" ];
        doCheck = false;
      };
      gomvp = pkgs.buildGoModule {
        name = "gomvp";
        src = inputs.gomvp-src;
        vendorSha256 = null;
      };
      json-to-struct = pkgs.buildGoModule rec {
        name = "json-to-struct";
        src = inputs.json-to-struct-src;
        vendorSha256 = "sha256-JAVBrhec5NNWKK+ayICu57u8zXrL6JGhl6pEhYhC7lg=";
        proxyVendor = true;
      };
      nvim-window = pkgs.vimUtils.buildVimPlugin {
        pname = "nvim-window";
        src = inputs.nvim-window-src;
        version = "master";
      };
      nvim-osc52 = pkgs.vimUtils.buildVimPlugin {
        pname = "nvim-osc52";
        src = inputs.nvim-osc52-src;
        version = "master";
      };
      mini-nvim = pkgs.vimUtils.buildVimPlugin {
        pname = "mini-nvim";
        src = inputs.mini-nvim-src;
        version = "master";
      };
      nvim-treesitter-master = pkgs.vimUtils.buildVimPlugin {
        pname = "nvim-treesitter";
        version = "master";
        src = inputs.nvim-treesitter-src;
      };
      nvim-guihua = pkgs.vimUtils.buildVimPlugin {
        pname = "nvim-guihua";
        version = "master";
        src = inputs.nvim-guihua-src;
      };
      rainbow-delimiters = pkgs.vimUtils.buildVimPlugin {
        pname = "rainbow-delimiters";
        version = "master";
        src = inputs.rainbow-delimiters-src;

      };
    };
  };
}
