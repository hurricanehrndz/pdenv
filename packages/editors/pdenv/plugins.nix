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
  gitsigns-nvim
  nvim-colorizer-lua
  nvim-window
  fidget-nvim
  lualine-nvim
  todo-comments-nvim

  # Fuzzy finder
  telescope-nvim
  plenary-nvim
  popup-nvim
  telescope-fzf-native-nvim
  telescope-file-browser-nvim

  # add some syntax highlighting
  (withSrc nvim-treesitter inputs.nvim-treesitter-src)

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
  lspsaga-nvim
  lsp-signature-nvim
  nvim-lsp-endhints
  tiny-code-action-nvim
  neodev-nvim

  # nice plugins
  nvim-osc52
  vim-tmux-navigator
  nvim-notify
  undotree
  vim-repeat
  mini-nvim
  nvim-ts-context-commentstring
  comment-nvim

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


  # testing
  FixCursorHold-nvim
  neotest
  neotest-go

]
