{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-2605.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    home-config.url = github:igsha/home-config/main;
    #hyprland.url = github:hyprwm/Hyprland;
    nixos-hardware = {
      url = github:nixos/nixos-hardware;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-mycollection = {
      url = github:igsha/tmux-mycollection/main;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uniplay = {
      url = github:igsha/uniplay/main;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-config, ... }@inputs:
    let
      system = "x86_64-linux";
      defaults = { pkgs, lib, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or "dirty";
        nixpkgs.overlays = [
          inputs.tmux-mycollection.overlays.default
          (final: prev: {
            uniplay = inputs.uniplay.packages.${prev.system}.default;
            nixpkgs-2605 = import inputs.nixpkgs-2605 {
              system = final.stdenv.hostPlatform.system;
            };
          })
          (import ./overlays.nix)
        ];
        nix = {
          registry = builtins.mapAttrs (k: v: {
            to = {
              type = "path";
              path = v.outPath;
            };
          }) (builtins.removeAttrs inputs [ "self" ]);
          package = pkgs.nixVersions.latest;
        };
        home-config-basedir = lib.mkForce ./.;
      };
      filterDirs = nixpkgs.lib.attrsets.filterAttrs (k: v: v == "directory");
      machines = filterDirs (builtins.readDir ./machines);
      configurateMachine = k: v: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          home-config.nixosModules.default
          defaults
          #inputs.hyprland.nixosModules.default
          ./machines/${k}
        ];
      };

    in {
      nixosConfigurations = builtins.mapAttrs configurateMachine machines;
    };
}
