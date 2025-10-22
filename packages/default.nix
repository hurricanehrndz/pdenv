{inputs, ...}: {
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: {
    packages = {
      neovim = pkgs.callPackage ./editors/neovim {inherit (inputs) neovim-src;};
      pdenv = pkgs.callPackage ./editors/pdenv {
        inherit (self') packages;
        inherit inputs';
        inherit inputs;
      };
      default = config.packages.pdenv;
      yamlfixer = with pkgs.python3Packages;
        buildPythonApplication {
          name = "yamlfixer";
          src = inputs.yamlfixer-src;
          doCheck = false;
          pyproject = true;
          build-system = [ setuptools ];
          propagatedBuildInputs = [setuptools yamllint];
        };
      # go-enum = pkgs.buildGoModule {
      #   name = "go-enum";
      #   src = inputs.go-enum-src;
      #   vendorHash = "sha256-+iQCOUg7rGfOgNvmj+lMLYb4A749hDK/3hexEw9IRmI=";
      # };
      # gomvp = pkgs.buildGoModule {
      #   name = "gomvp";
      #   src = inputs.gomvp-src;
      #   vendorHash = null;
      # };
      # json-to-struct = pkgs.buildGoModule rec {
      #   name = "json-to-struct";
      #   src = inputs.json-to-struct-src;
      #   vendorHash = "sha256-JAVBrhec5NNWKK+ayICu57u8zXrL6JGhl6pEhYhC7lg=";
      #   proxyVendor = true;
      # };
    };
  };
}
