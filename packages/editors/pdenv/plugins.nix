{
  inputs,
  pkgs,
  packages,
  nvimPython,
  ...
}: let
  withSrc = pkg: src: pkg.overrideAttrs (_: {inherit src;});
in
  with pkgs.vimPlugins;
  with packages; [
    # Theme
    tokyonight-nvim
    alpha-nvim
    nvim-web-devicons
    indent-blankline-nvim
    (withSrc gitsigns-nvim inputs.gitsigns-src)
    (withSrc nvim-colorizer-lua inputs.nvim-colorizer-src)

    # Fuzzy finder
    (withSrc telescope-nvim inputs.telescope-nvim-src)
    plenary-nvim
    popup-nvim
    telescope-fzf-native-nvim
    telescope-file-browser-nvim
    telescope-dap-nvim

    # add some syntax highlighting
    nvim-treesitter-master

    # functionality
    toggleterm-nvim

    # comment
    comment-nvim
    nvim-window

    # which key did I just hit
    which-key-nvim
    # what's did I do wrong
    trouble-nvim

    # add completion
    nvim-cmp
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp-buffer
    cmp-cmdline
    cmp-zsh # next is required
    deol-nvim
    lsp_lines-nvim

    # snippets
    luasnip
    cmp_luasnip
    friendly-snippets
    vim-snippets

    # formatters, linters
    null-ls-nvim

    # add lsp config
    (withSrc nvim-lspconfig inputs.nvim-lspconfig-src)
    (withSrc nvim-lightbulb inputs.nvim-lightbulb-src)
    neodev-nvim

    # nice plugins
    nvim-osc52
    vim-tmux-navigator
    nvim-notify
    undotree

    feline-nvim
    mini-nvim

    vim-better-whitespace

    # pictograms
    lspkind-nvim

    # debugging
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-python

    # filetype
    Jenkinsfile-vim-syntax
    vim-puppet

    diffview-nvim

    # motion
    (withSrc flash-nvim inputs.flash-nvim-src)
  ]
