{ neovim
, pkgs
, lib
, fetchFromGitHub
, fetchurl
, rustPlatform
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  version = "0.20.9";
  sha256 = "sha256-NxWqpMNwu5Ajffw1E2q9KS4TgkCH6M+ctFyi9Jp0tqQ=";
  src = fetchFromGitHub {
    owner = "tree-sitter";
    repo = "tree-sitter";
    rev = "v${version}";
    inherit sha256;
    fetchSubmodules = true;
  };
  tree-sitter = pkgs.tree-sitter.overrideAttrs (drv: rec {
    name = "tree-sitter";
    inherit src version;
    cargoDeps = rustPlatform.importCargoLock {
      lockFile = fetchurl {
        url =
          "https://raw.githubusercontent.com/tree-sitter/tree-sitter/v${version}/Cargo.lock";
        sha256 = "sha256-CVxS6AAHkySSYI9vY9k1DLrffZC39nM7Bc01vfjMxWk=";
      };
      allowBuiltinFetchGit = true;
    };
  });
in
#  neovim/neovim contrib flake
neovim.overrideAttrs (o: {
  buildInputs = [ tree-sitter ] ++ o.buildInputs;
})
