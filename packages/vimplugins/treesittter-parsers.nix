{pkgs, ...}: let
  nvim-plugintree = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.c
    p.lua
    p.nix
    p.bash
    p.cpp
    p.json
    p.python
    p.markdown
  ]);
in {
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = nvim-plugintree.dependencies;
  };
}
