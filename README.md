# Show what's supported
``` bash
nix flake show "github:zzorz/dotfiles"
```
or using `nix repl`, `:lf` function.
# Installation
## for non nixos host
``` bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
``` bash
echo 'extra-experimental-features = nix-command flakes' >> /etc/nix/nix.conf
```
``` bash
nix run "github:zzorz/dotfiles#homeConfigurations.$(whoami).activationPackage"
```
``` bash
home-manager switch --flake "github:zzorz/dotfiles#$(whoami)"
```
## for nixos
``` bash
nixos-rebuild switch --flake "github:zzorz/dotfiles#$(hostname)"
```
