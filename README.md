# About

`dotfiles` is a set of NixOS configurations for several machines.

# How to build and switch

Simple solution is:
```
sudo nixos-rebuild switch --flake .#
```

# Detailed build and switch

Build, install and activate configuration manually.

Build configuration:
```
nix build .#nixosConfigurations.$(hostname).config.system.build.toplevel
```

Install configuration into profile:
```
sudo nix-env -p /nix/var/nix/profiles/system --set ./result
```
You cannot use `nix profile --profile /nix/var/nix/profiles/system` yet.

Activate configuration:
```
sudo ./result/bin/switch-to-configuration switch
```

# Fresh install

Preferable partitioning:

* `/dev/sda1` - boot partition about 1G;
* `/dev/sda2` - root partition at least 200G;
* `/dev/sda3` - home partition;
* `/dev/sda4` - swap partition.

After disk partitioning mount the first 3 partitions into `/mnt` and run:
```
sudo nixos-install --root /mnt --no-channel-copy --flake $PWD#<machine>
```
`$PWD` contains this dotfiles repo.

# Installation of parts

## Tmux

Tmux can be installed into profile as ordinary:
```
nix profile install nixpkgs#tmux
```

Plugins for tmux can be installed from the machine `ginnungagap`:
```
nix profile install .#nixosConfigurations.ginnungagap.pkgs.my-tmux-plugins
```
or directly from github:
```
nix profile install github:igsha/dotfiles#nixosConfigurations.ginnungagap.pkgs.my-tmux-plugins
```

Then set symbolic link for the tmux's configuration file using `stow`:
```
stow -v -t $HOME -d $PWD/fragments/programs/tmux/home-config tmux
```
There is no way to make the symbolic link directly from github.

## Neovim

Install `neovim` directly from github:
```
nix profile install github:igsha/dotfiles#nixosConfigurations.ginnungagap.config.programs.neovim.finalPackage
```

Vim-packages will be integrated into `neovim`, no need to install it separately.

Then set symbolic link for the nvim's configuration file using `stow`:
```
stow -v -t $HOME -d $PWD/fragments/programs/neovim/home-config nvim
```
There is no way to make the symbolic link directly from github.
