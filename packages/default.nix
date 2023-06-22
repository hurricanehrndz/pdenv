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
      pdenv = pkgs.callPackage ./editors/pdenv {inherit (self') packages; inherit inputs;};
      codelldb = let pkgs = inputs.nixpkgs-pr211321.legacyPackages.${system}; in pkgs.vscode-extensions.vadimcn.vscode-lldb;
      swiftformat = pkgs.callPackage ./swift/swiftformat {inherit (inputs) swiftformat-src;};
      swiftlint = pkgs.callPackage ./swift/swiftlint {inherit (inputs) swiftlint-src;};
      yamllint = pkgs.callPackage ./yaml/yamllint.nix {inherit (inputs) yamllint-src;};
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
