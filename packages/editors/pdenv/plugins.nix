{
  inputs,
  pkgs,
  packages,
  nvimPython,
  ...
}: let
  withSrc = pkg: src: pkg.overrideAttrs (_: {inherit src;});
  # Chocolatier.nvim
  chocolatier = pkgs.vimUtils.buildVimPlugin {
    name = "chocolatier";
    src = inputs.chocolatier-nvim-src;
  };
  papercolor = pkgs.vimUtils.buildVimPlugin {
    name = "papercolor";
    src = inputs.papercolor-src;
  };
in
  with pkgs.vimExtraPlugins; [
    # Theme
    rose-pine
    chocolatier
    papercolor
    everforest-nvim
    tokyonight-nvim
    catppuccin
    gitsigns-nvim
    nvim-colorizer-catgoose
    nvim-window
    fidget-nvim
    lualine-nvim
    todo-comments-nvim
    # folke stuff
    lazydev-nvim
    snacks-nvim
    # required for noice
    nui-nvim
    noice-nvim

    # add some syntax highlighting
    (withSrc pkgs.vimPlugins.nvim-treesitter.withAllGrammars inputs.nvim-treesitter-src)

    # functionality
    toggleterm-nvim

    # which key did I just hit
    which-key-nvim
    # what's did I do wrong
    trouble-nvim
    diffview-nvim

    # add completion
    blink-cmp

    # snippets
    friendly-snippets

    # formatters, linters
    conform-nvim
    pkgs.vimPlugins.vim-better-whitespace
    nvim-lint

    # add lsp config
    nvim-lspconfig
    nvim-lsp-endhints
    tiny-code-action-nvim

    # nice plugins
    nvim-osc52
    undotree
    vim-repeat
    mini-nvim
    nvim-ts-context-commentstring
    pkgs.vimPlugins.comment-nvim
    markdown-meandering-programmer
    markdown-togglecheck
    treesitter-utils
    pkgs.vimPlugins.vim-tmux-navigator
    no-neck-pain-nvim

    # pictograms
    lspkind-nvim

    # debugging
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-python
    nvim-dap-go
    nvim-nio

    # filetype
    pkgs.vimPlugins.Jenkinsfile-vim-syntax
    pkgs.vimPlugins.vim-puppet

    # testing
    pkgs.vimPlugins.FixCursorHold-nvim
    neotest
    pkgs.vimPlugins.neotest-go

    # notes
    zk-nvim
  ]
