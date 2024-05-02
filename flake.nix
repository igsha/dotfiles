{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-23.11;
    nixos-hardware.url = github:nixos/nixos-hardware/master;
    nixos-unstable.url = github:nixos/nixpkgs?ref=nixos-unstable;
    home-config = {
      url = github:igsha/home-config/main;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yt-dlp-plugins = {
      url = github:igsha/yt-dlp-plugins/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dino = {
      url = github:igsha/dino?ref=nix-support;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-unstable, nixos-hardware, home-config, yt-dlp-plugins, dino }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixos-unstable { inherit system; };
      defaults = { pkgs, lib, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or "dirty";
        nixpkgs.overlays = [
          (final: prev: {
            qutebrowser = unstable.qutebrowser;
            mpv-unwrapped = unstable.mpv-unwrapped; # need for mpv
            wrapMpv = unstable.wrapMpv; # need for mpv
            yt-dlp = unstable.yt-dlp;
            telegram-desktop = unstable.telegram-desktop;
            nh = unstable.nh;
            upower = unstable.upower;
            dino-plus = dino.packages.${system}.default;
          })
          yt-dlp-plugins.overlays.default
        ];
        nix.registry = builtins.mapAttrs (k: v: {
          to = {
            type = "path";
            path = v.outPath;
          };
        }) (builtins.removeAttrs inputs [ "self" ]);
        home-config-basedir = lib.mkForce (builtins.toString ./.);
      };
      filterDirs = nixpkgs.lib.attrsets.filterAttrs (k: v: v == "directory");
      machines = filterDirs (builtins.readDir ./machines);
      configurateMachine = k: v: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          home-config.nixosModules.default
          defaults
          ./machines/${k}
        ];
      };

    in {
      nixosConfigurations = builtins.mapAttrs configurateMachine machines;
    };
}
