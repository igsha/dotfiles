{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-unstable;
    nixos-hardware.url = github:nixos/nixos-hardware/master;
    home-config.url = github:igsha/home-config/main;
    yt-dlp-plugins = {
      url = github:igsha/yt-dlp-plugins/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dino = {
      url = github:igsha/dino?ref=nix-support;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-mycollection = {
      url = github:igsha/tmux-mycollection/main;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    news-reader = {
      url = github:igsha/news-reader/main;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-config, ... }@inputs:
    let
      system = "x86_64-linux";
      defaults = { pkgs, lib, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or "dirty";
        nixpkgs.overlays = [
          (final: prev: {
            dino-plus = inputs.dino.packages.${prev.system}.default;
            news-reader = inputs.news-reader.packages.${prev.system}.default;
          })
          inputs.yt-dlp-plugins.overlays.default
          inputs.tmux-mycollection.overlays.default
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
          ./machines/${k}
        ];
      };

    in {
      nixosConfigurations = builtins.mapAttrs configurateMachine machines;
    };
}
