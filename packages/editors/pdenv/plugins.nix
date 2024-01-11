{ inputs
, pkgs
, packages
, nvimPython
, ...
}:
let
  withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });
in
with pkgs.vimExtraPlugins;
with pkgs.vimPlugins; [
  # Theme
  tokyonight-nvim
  catppuccin
  alpha-nvim
  nvim-web-devicons
  indent-blankline-nvim
  gitsigns-nvim
  nvim-colorizer-lua
  todo-comments-nvim
  nvim-window
  nvim-ts-context-commentstring

  # Fuzzy finder
  telescope-nvim
  plenary-nvim
  popup-nvim
  telescope-fzf-native-nvim
  telescope-file-browser-nvim

  # add some syntax highlighting
  nvim-treesitter

  # functionality
  toggleterm-nvim

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
  conform-nvim
  vim-better-whitespace
  nvim-lint

  # add lsp config
  nvim-lspconfig
  nvim-lightbulb
  neodev-nvim

  # nice plugins
  nvim-osc52
  vim-tmux-navigator
  nvim-notify
  undotree

  # feline-nvim
  lualine-nvim
  mini-nvim

  # pictograms
  lspkind-nvim

  # debugging
  nvim-dap
  nvim-dap-ui
  nvim-dap-virtual-text
  nvim-dap-python
  telescope-dap-nvim

  # filetype
  Jenkinsfile-vim-syntax
  vim-puppet

  diffview-nvim

  # rainbow
  rainbow-delimiters-nvim

  # testing
  FixCursorHold-nvim
  neotest
  neotest-go

  vim-repeat
]
