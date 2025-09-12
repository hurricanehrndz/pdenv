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
    themery-nvim
    rose-pine
    chocolatier
    papercolor
    everforest-nvim
    tokyonight-nvim
    catppuccin
    alpha-nvim
    nvim-web-devicons
    gitsigns-nvim
    nvim-colorizer-catgoose
    nvim-window
    fidget-nvim
    lualine-nvim
    todo-comments-nvim

    # Fuzzy finder
    plenary-nvim
    popup-nvim
    (withSrc pkgs.vimPlugins.telescope-nvim inputs.telescope-nvim-src)
    telescope-fzf-native-nvim
    telescope-file-browser-nvim

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
    nvim-cmp
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp-buffer
    cmp-cmdline
    cmp-dictionary
    cmp-zsh # next is required
    pkgs.vimPlugins.deol-nvim
    # pkgs.vimPlugins.lsp_lines-nvim

    # snippets
    pkgs.vimPlugins.luasnip
    pkgs.vimPlugins.cmp_luasnip
    friendly-snippets
    pkgs.vimPlugins.vim-snippets

    # formatters, linters
    conform-nvim
    pkgs.vimPlugins.vim-better-whitespace
    nvim-lint

    # add lsp config
    nvim-lspconfig
    lspsaga-nvim
    lsp-signature-nvim
    nvim-lsp-endhints
    tiny-code-action-nvim
    neodev-nvim

    # nice plugins
    nvim-osc52
    nvim-notify
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
    pkgs.vimPlugins.telescope-dap-nvim

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
