{
  pkgs,
  nvimPython,
  ...
}:
with pkgs;
[
  # go
  gofumpt
  golines
  golangci-lint
  revive
  gotools
  gopls
  reftools
  gomodifytags
  gotests
  iferr
  impl
  delve
  ginkgo
  richgo
  gotestsum
  govulncheck
  mockgen
  # go-enum
  # gomvp
  # json-to-struct

  # lua
  lua-language-server
  stylua

  # nix
  nixd
  alejandra
  nixfmt

  # shell
  beautysh
  nodePackages.bash-language-server
  shellcheck
  shfmt

  # markdwon
  nodePackages.markdownlint-cli
  vale
  mermaid-cli

  # git
  gitlint

  # python
  black
  basedpyright
  isort
  ruff
  nvimPython

  # terraform
  terraform-ls
  tflint

  # one-ofs
  nodePackages.prettier
  puppet-lint

  # other useful binaries
  zsh
  (ripgrep.override { withPCRE2 = true; })
  bashInteractive
  bat
  coreutils
  direnv
  eza
  fd
  findutils
  fzf
  gawk
  gitlint
  codespell

  # snacks dashboard
  dwt1-shell-color-scripts

  # treesitter cli
  pkgs.treesitterFlake.cli

  # yaml
  yamlfmt
  # cpp, c, swift -- I really don't debug
  # vscode-ext.vadimcn.vscode-lldb
]
