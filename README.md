# PDENV

Personal Development Environment - design for me by me to meet my needs.

## How to use

1; Install nix on systems without root use the latest static build from [hydra][nix-hydra]

```sh
# using: https://hydra.nixos.org/job/nix/maintenance-2.16/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist
mkdir ~/.local/tmp/
curl -o ~/.local/bin/nix -L https://hydra.nixos.org/job/nix/maintenance-2.16/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist
chmod +x ~/.local/bin/nix
```

2; Install nix.conf from this repo

```sh
mkdir ~/.config/nix
curl -o ~/.config/nix/nix.conf -L https://raw.githubusercontent.com/hurricanehrndz/pdenv/main/nix.conf
```

3; Run pdenv

```sh
~/.local/tmp/nix run github:hurricanehrndz/pdenv
```

[nix-hydra]: https://hydra.nixos.org/project/nix
