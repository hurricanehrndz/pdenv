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
    {
      plugin = tokyonight-nvim;
      config = ''
        require("hrndz.plugins.tokyonight")
      '';
    }
    {
      plugin = indent-blankline-nvim;
      config = ''
        require("hrndz.plugins.indentblankline")
      '';
    }
    {
      plugin = withSrc gitsigns-nvim inputs.gitsigns-src;
      config = ''
        require("hrndz.plugins.gitsigns")
      '';
    }
    {
      plugin = withSrc nvim-colorizer-lua inputs.nvim-colorizer-src;
      config = ''
        colorizer = require("colorizer")
        colorizer.setup()
      '';
    }
    {
      plugin = nvim-web-devicons;
      config = ''
        local devicons = require("nvim-web-devicons")
        devicons.setup({ default = true })
      '';
    }
    # Fuzzy finder
    {
      plugin = withSrc telescope-nvim inputs.telescope-nvim-src;
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
      config = ''
        require("hrndz.plugins.treesitter")
      '';
    }
    # functionality
    {
      plugin = toggleterm-nvim;
      config = ''
        require("hrndz.plugins.toggleterm")
      '';
    }
    # comment
    {
      plugin = comment-nvim;
      config = ''
        require("hrndz.plugins.comment")
      '';
    }
    {
      plugin = nvim-window;
      config = ''
        require("hrndz.plugins.winpicker")
      '';
    }
    # which key did I just hit
    {
      plugin = which-key-nvim;
      config = ''
        require("hrndz.plugins.whichkey")
      '';
    }
    # what's did I do wrong
    {
      plugin = trouble-nvim;
      config = ''
        require("hrndz.plugins.trouble")
      '';
    }
    # add completion
    {
      plugin = nvim-cmp;
      config = ''
        require("hrndz.plugins.completion")
      '';
    }
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp-buffer
    cmp-cmdline
    cmp-zsh # next is required
    deol-nvim
    (withSrc go-nvim inputs.go-nvim-src)
    nvim-guihua
    lsp_lines-nvim

    # snippets
    luasnip
    cmp_luasnip
    friendly-snippets
    vim-snippets

    # formatters, linters
    null-ls-nvim

    # add lsp config
    {
      plugin = withSrc nvim-lspconfig inputs.nvim-lspconfig-src;
      config = ''
        require("hrndz.lsp")
      '';
    }
    neodev-nvim

    # nice plugins
    nvim-osc52
    vim-tmux-navigator
    nvim-notify
    undotree
    {
      plugin = feline-nvim;
      config = ''
        require("hrndz.plugins.statusline")
      '';
    }
    {
      plugin = mini-nvim;
      config = ''
        require("hrndz.plugins.mini")
      '';
    }
    {
      plugin = vim-better-whitespace;
      config = ''
        require("hrndz.plugins.whitespace")
      '';
    }

    # pictograms
    lspkind-nvim

    # debugging
    {
      plugin = nvim-dap;
      config = ''
        require("hrndz.plugins.dap")
        local dap_python = require("dap-python")
        ---@diagnostic disable-next-line: param-type-mismatch
        dap_python.setup("${nvimPython}/bin/python")

        local dap = require('dap')
        local codelldb_bin = "${packages.codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"
        dap.adapters.codelldb = {
        type = 'server',
        port = "''${port}",
          executable = {
            command = codelldb_bin,
            args = {"--port", "''${port}", "--liblldb", "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"},
          }
        }
        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "''${workspaceFolder}",
            stopOnEntry = false,
          },
        }
        dap.configurations.swift = dap.configurations.cpp
      '';
    }
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-python
    vim-puppet
    {
      plugin = alpha-nvim;
      config = ''
        require("hrndz.plugins.alpha")
      '';
    }
    {
      plugin = diffview-nvim;
      config = ''
        require("diffview").setup({})
      '';
    }
  ]
