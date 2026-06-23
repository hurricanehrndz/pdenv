# Common tasks for the pdenv flake.
# Requires Nix; enter the devshell with `nix develop` (or direnv).

default:
    @just --list

[group('nix')]
build *args: lock
    nix build .#pdenv --accept-flake-config {{args}}

# Run the built pdenv neovim instance.
[group('nix')]
run *args:
    nix run .#pdenv --accept-flake-config {{args}}

[group('nix')]
fmt *args:
    nix fmt {{args}}

[group('nix')]
check *args:
    nix flake check {{args}}

[group('nix')]
update *args:
    nix flake update --no-use-registries {{args}}

[group('nix')]
lock:
    nix flake lock --no-use-registries

[group('nix')]
clean *args:
    nix-collect-garbage --delete-older-than 3d {{args}}
