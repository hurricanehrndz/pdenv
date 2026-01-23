{
  pkgs,
  opencode-nvim-src,
  nvim-treesitter-src,
  ...
}:
let
  withSrc =
    pkg: src:
    pkg.overrideAttrs (_: {
      inherit src;
    });
  opencode-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "opencode-nvim";
    src = opencode-nvim-src;
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
  (withSrc pkgs.vimPlugins.nvim-treesitter.withAllGrammars nvim-treesitter-src)

  # which key did I just hit
  which-key-nvim-folke
  # what's did I do wrong
  trouble-nvim-folke
  diffview-nvim-sindrets

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
  mini-nvim-nvim-mini
  nvim-ts-context-commentstring-JoosepAlviste
  pkgs.vimPlugins.comment-nvim
  markdown-meandering-programmer-MeanderingProgrammer
  Navigator-nvim-numToStr
  no-neck-pain-nvim-shortcuts

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
  # async
  plenary-nvim-nvim-lua

  # ai
  opencode-nvim

  # wezterm
  wezterm-nvim-willothy
  wezterm-types-DrKJeff16

  # notes
  zk-nvim-zk-org
]
