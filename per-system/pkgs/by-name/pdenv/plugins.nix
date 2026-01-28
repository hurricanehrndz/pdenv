{
  inputs,
  pkgs,
  ...
}:
let
  withSrc =
    pkg: src:
    pkg.overrideAttrs (_: {
      inherit src;
    });
  opencode-nvim = pkgs.vimUtils.buildVimPlugin  {
    name = "opencode-nvim";
    src = inputs.opencode-nvim-src;
  };
in
with pkgs.vimExtraPlugins;
[
  # Theme
  rose-pine-rose-pine
  tokyonight-nvim-folke
  catppuccin-catppuccin
  gitsigns-nvim-lewis6991
  nvim-colorizer-catgoose-catgoose
  nvim-window-yorickpeterse
  fidget-nvim-j-hui
  lualine-nvim-nvim-lualine
  todo-comments-nvim-folke
  # folke stuff
  lazydev-nvim-folke
  snacks-nvim-folke
  # required for noice
  nui-nvim-MunifTanjim
  noice-nvim-folke

  # add some syntax highlighting
  (withSrc pkgs.vimPlugins.nvim-treesitter.withAllGrammars inputs.nvim-treesitter-src)

  # which key did I just hit
  which-key-nvim-folke
  # what's did I do wrong
  trouble-nvim-folke
  diffview-nvim-sindrets

  # distributions
  mini-nvim-nvim-mini

  # add completion
  pkgs.blinkcmpFlake.blink-cmp

  # snippets
  friendly-snippets-rafamadriz

  # formatters, linters
  conform-nvim-stevearc
  pkgs.vimPlugins.vim-better-whitespace
  nvim-lint-mfussenegger

  # add lsp config
  nvim-lspconfig-neovim
  nvim-lsp-endhints-chrisgrieser

  # CodeActions preview
  tiny-code-action-nvim-rachartier

  # nice plugins
  nvim-osc52-ojroques
  undotree-mbbill
  vim-repeat-tpope
  no-neck-pain-nvim-shortcuts

  # markdown
  markdown-meandering-programmer-MeanderingProgrammer

  # commenting
  nvim-ts-context-commentstring-JoosepAlviste
  pkgs.vimPlugins.comment-nvim

  # debugging
  nvim-dap-mfussenegger
  nvim-dap-ui-rcarriga
  nvim-dap-virtual-text-theHamsta
  nvim-dap-python-mfussenegger
  nvim-dap-go-leoluz

  # filetype
  pkgs.vimPlugins.Jenkinsfile-vim-syntax
  pkgs.vimPlugins.vim-puppet

  # neotest testing
  nvim-nio-nvim-neotest
  neotest-nvim-neotest
  neotest-golang-fredrikaverpil
  pkgs.vimPlugins.FixCursorHold-nvim

  # async - used by many plugins
  plenary-nvim-nvim-lua

  # ai
  opencode-nvim
  (withSrc pkgs.vimPlugins.claudecode-nvim inputs.claudecode-nvim-src)

  # wezterm/tmux
  Navigator-nvim-numToStr
  smart-splits-nvim-mrjones2014
  wezterm-types-DrKJeff16

  # notes
  zk-nvim-zk-org
]
