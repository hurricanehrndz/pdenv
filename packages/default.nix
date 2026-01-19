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
      default = config.packages.pdenv;
      pdenv = pkgs.callPackage ./editors/pdenv {
        inherit (self') packages;
        inherit inputs';
        inherit inputs;
      };
      yamlfixer = with pkgs.python3Packages;
        buildPythonApplication {
          name = "yamlfixer";
          src = inputs.yamlfixer-src;
          doCheck = false;
          pyproject = true;
          build-system = [ setuptools ];
          propagatedBuildInputs = [setuptools yamllint];
        };
    };
  };
}
