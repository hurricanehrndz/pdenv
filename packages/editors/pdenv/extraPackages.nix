{
  pkgs,
  packages,
  nvimPython,
  ...
}:
with pkgs;
with packages; [
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
  go-enum
  gomvp
  json-to-struct

  # lua
  sumneko-lua-language-server
  stylua

  # nix
  alejandra
  nixpkgs-fmt

  # shell
  beautysh
  nodePackages.bash-language-server
  shellcheck
  shfmt

  # markdwon
  nodePackages.markdownlint-cli
  vale

  # swift
  # pkgs.swiftformat
  # pkgs.swiftlint
  # sourcekit-lsp

  # yaml
  yamlfixer
  yamllint

  # python
  black
  pyright
  nvimPython

  # terraform
  terraform-ls
  tflint

  # one-ofs
  nodePackages.prettier
  puppet-lint

  # other useful binaries
  zsh
  (ripgrep.override {withPCRE2 = true;})
  bashInteractive
  bat
  coreutils
  direnv
  eza
  fd
  findutils
  fzf
  gawk

]
