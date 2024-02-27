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
