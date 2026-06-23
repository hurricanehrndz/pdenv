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
  copy-reference-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "copy-reference-nvim";
    src = inputs.copy-reference-nvim-src;
  };
  blink-cmp = pkgs.blinkcmpFlake.blink-cmp.overrideAttrs (_: {
    doCheck = false;
  });
  lazy-nvim = pkgs.vimExtraPlugins.lazy-nvim-folke.overrideAttrs (_: {
    nvimRequireCheck = [
      "lazy.docs"
      "lazy.util"
    ];
  });
  snacks-nvim = pkgs.vimExtraPlugins.snacks-nvim-folke.overrideAttrs (_: {
    # Optional Trouble profiler bridge; add Trouble here if the profiler integration is used.
    nvimSkipModules = [ "trouble.sources.profiler" ];
  });
  tokyonight-nvim = pkgs.vimExtraPlugins.tokyonight-nvim-folke.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ lazy-nvim ];
  });
  catppuccin-nvim = pkgs.vimExtraPlugins.catppuccin-catppuccin.overrideAttrs (_: {
    # Integration module assumes catppuccin setup state exists at require time.
    nvimSkipModules = [ "catppuccin.groups.integrations.noice" ];
  });
  noice-nvim = pkgs.vimExtraPlugins.noice-nvim-folke.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [
      pkgs.vimExtraPlugins.nui-nvim-MunifTanjim
      snacks-nvim
      pkgs.vimExtraPlugins.mini-nvim-nvim-mini
    ];
  });
  which-key-nvim = pkgs.vimExtraPlugins.which-key-nvim-folke.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ lazy-nvim ];
  });
  trouble-nvim = pkgs.vimExtraPlugins.trouble-nvim-folke.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ lazy-nvim ];
    # Docs generator executes at require time and needs initialized Trouble config.
    nvimSkipModules = [ "trouble.docs" ];
  });
  todo-comments-nvim = pkgs.vimExtraPlugins.todo-comments-nvim-folke.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ trouble-nvim ];
    # FZF integration is optional in this config; add fzf-lua here if enabling it.
    nvimSkipModules = [ "todo-comments.fzf" ];
  });
  tiny-code-action-nvim = pkgs.vimExtraPlugins.tiny-code-action-nvim-rachartier.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ snacks-nvim ];
  });
  plenary-nvim = pkgs.vimExtraPlugins.plenary-nvim-nvim-lua.overrideAttrs (_: {
    # Optional neorocks helper is not needed by this config.
    nvimSkipModules = [ "plenary.neorocks.init" ];
  });
  nvim-nio = pkgs.vimExtraPlugins.nvim-nio-nvim-neotest;
  nvim-dap = pkgs.vimExtraPlugins.nvim-dap-mfussenegger;
  nvim-dap-ui = pkgs.vimExtraPlugins.nvim-dap-ui-rcarriga.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [
      nvim-dap
      nvim-nio
    ];
  });
  nvim-dap-virtual-text = pkgs.vimExtraPlugins.nvim-dap-virtual-text-theHamsta.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ nvim-dap ];
  });
  nvim-dap-python = pkgs.vimExtraPlugins.nvim-dap-python-mfussenegger.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ nvim-dap ];
  });
  nvim-dap-go = pkgs.vimExtraPlugins.nvim-dap-go-leoluz.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ nvim-dap ];
  });
  neotest-nvim = pkgs.vimExtraPlugins.neotest-nvim-neotest.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [
      plenary-nvim
      nvim-nio
    ];
  });
  neotest-golang = pkgs.vimExtraPlugins.neotest-golang-fredrikaverpil.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [
      neotest-nvim
      plenary-nvim
      nvim-nio
    ];
  });
  zk-nvim = pkgs.vimExtraPlugins.zk-nvim-zk-org.overrideAttrs (old: {
    dependencies = (old.dependencies or [ ]) ++ [ snacks-nvim ];
    # Config uses snacks_picker; other picker integrations are intentionally not installed.
    nvimSkipModules = [
      "zk.pickers.minipick"
      "zk.pickers.telescope"
      "zk.pickers.fzf_lua"
    ];
  });
in
with pkgs.vimExtraPlugins;
[
  # Theme
  rose-pine-rose-pine
  tokyonight-nvim
  catppuccin-nvim
  gitsigns-nvim-lewis6991
  nvim-colorizer-catgoose-catgoose
  nvim-window-yorickpeterse
  fidget-nvim-j-hui
  lualine-nvim-nvim-lualine
  todo-comments-nvim
  # folke stuff
  lazydev-nvim-folke
  snacks-nvim
  # required for noice
  nui-nvim-MunifTanjim
  noice-nvim

  # add some syntax highlighting
  (pkgs.vimPlugins.nvim-treesitter.withPlugins (
    grammars: with grammars; [
      bash
      c
      go
      javascript
      json
      lua
      markdown
      markdown_inline
      nix
      objc
      python
      ruby
      rust
      swift
      toml
      tsx
      typescript
      yaml
      zsh
    ]
  ))

  # which key did I just hit
  which-key-nvim
  # what's did I do wrong
  trouble-nvim
  diffview-nvim-sindrets

  # distributions
  mini-nvim-nvim-mini

  # add completion
  blink-cmp

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
  tiny-code-action-nvim

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
  nvim-dap
  nvim-dap-ui
  nvim-dap-virtual-text
  nvim-dap-python
  nvim-dap-go

  # filetype
  pkgs.vimPlugins.Jenkinsfile-vim-syntax
  pkgs.vimPlugins.vim-puppet

  # neotest testing
  nvim-nio
  neotest-nvim
  neotest-golang
  pkgs.vimPlugins.FixCursorHold-nvim

  # async - used by many plugins
  plenary-nvim

  # copy reference
  copy-reference-nvim

  # wezterm types (lazydev)
  wezterm-types-DrKJeff16

  # notes
  zk-nvim
]
