# PDENV

Personal Development Environment - design for me by me to meet my needs.

## How to use

1. Install nix, follow usual [instructions][nix-install]. On systems without
   root use the latest static build from [hydra][nix-hydra].

    ```sh
    # using: https://hydra.nixos.org/job/nix/maintenance-2.16/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist
    mkdir ~/.local/tmp/
    curl -o ~/.local/bin/nix -L https://hydra.nixos.org/job/nix/maintenance-2.16/buildStatic.x86_64-linux/latest/download-by-type/file/binary-dist
    chmod +x ~/.local/bin/nix
    ```

2. Install nix.conf from this repo

    ```sh
    mkdir ~/.config/nix
    curl -o ~/.config/nix/nix.conf -L https://raw.githubusercontent.com/hurricanehrndz/pdenv/main/nix.conf
    ```

3. Run pdenv

    ```sh
    ~/.local/tmp/nix run github:hurricanehrndz/pdenv --accept-flake-config
    ```

## Notes:

- How to get 50/72 rule enable in gitcommit TS

```
:TSEditQueryUserAfter highlight gitcommit
# Hit 1 for new file and paste
;; extends

((subject) @comment.error
  (#vim-match? @comment.error ".\{50,}")
  (#offset! @comment.error 0 50 0 0))

((message_line) @comment.error
  (#vim-match? @comment.error ".\{72,}")
  (#offset! @comment.error 0 72 0 0))
```

[nix-hydra]: https://hydra.nixos.org/project/nix
[nix-install]: https://nixos.org/download.html

