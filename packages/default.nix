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
      };
      codelldb = let pkgs = inputs.nixpkgs-pr211321.legacyPackages.${system}; in pkgs.vscode-extensions.vadimcn.vscode-lldb;
      swiftformat = pkgs.callPackage ./swift/swiftformat {inherit (inputs) swiftformat-src;};
      swiftlint = pkgs.callPackage ./swift/swiftlint {inherit (inputs) swiftlint-src;};
      # yamllint = with pkgs.python3Packages;
      #   buildPythonApplication {
      #     name = "yamllint";
      #     src = inputs.yamllint-src;
      #     doCheck = false;
      #     propagatedBuildInputs = [setuptools pyaml pathspec];
      #   };
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
        vendorSha256 = "sha256-tIY3CJnb6QuHBSDjfsxRZRUm1n3NTWLSEE1YruNksU4=";
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
      nvim-window = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-window";
        src = inputs.nvim-window-src;
        version = "master";
      };
      nvim-osc52 = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-osc52";
        src = inputs.nvim-osc52-src;
        version = "master";
      };
      mini-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "mini-nvim";
        src = inputs.mini-nvim-src;
        version = "master";
      };
      nvim-treesitter-master = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-treesitter";
        version = "master";
        src = inputs.nvim-treesitter-src;
      };
      nvim-guihua = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "nvim-guihua";
        version = "master";
        src = inputs.nvim-guihua-src;
      };
    };
  };
}
