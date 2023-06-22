{
  inputs,
  pkgs,
  packages,
  ...
}: let
  withSrc = pkg: src: pkg.overrideAttrs (_: {inherit src;});
in
  with pkgs.vimPlugins;
  with packages; [
    # Theme
    {
      plugin = tokyonight-nvim;
      type = "lua";
      config = ''
        require("hrndz.plugins.tokyonight")
      '';
    }
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config = ''
        require("hrndz.plugins.indentblankline")
      '';
    }
    {
      plugin = withSrc gitsigns-nvim inputs.gitsigns-src;
      type = "lua";
      config = ''
        require("hrndz.plugins.gitsigns")
      '';
    }
    {
      plugin = withSrc nvim-colorizer-lua inputs.nvim-colorizer-src;
      type = "lua";
      config = ''
        colorizer = require("colorizer")
        colorizer.setup()
      '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = ''
        local devicons = require("nvim-web-devicons")
        devicons.setup({ default = true })
      '';
    }
    # Fuzzy finder
    {
      plugin = withSrc telescope-nvim inputs.telescope-nvim-src;
      type = "lua";
      config = ''
        require("hrndz.plugins.telescope")
      '';
    }
    plenary-nvim
    popup-nvim
    telescope-fzf-native-nvim
    telescope-file-browser-nvim
    telescope-dap-nvim

    # add some syntax highlighting
    {
      plugin = nvim-treesitter-master;
      type = "lua";
      config = ''
        require("hrndz.plugins.treesitter")
      '';
    }
  ]
