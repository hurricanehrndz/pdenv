{
  pkgs,
  packages,
  nvimPython,
  inputs,
  system,
  ...
}: let
  vscode-ext = inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace;
in
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
    nil
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
    gitlint
    codespell

    # snacks dashboard
    dwt1-shell-color-scripts

    # cpp, c, swift
    vscode-ext.vadimcn.vscode-lldb
  ]
