{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixos-hardware.url = "nixos-hardware";
    nixos-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixos-unstable, nixos-hardware }:
    let
      system = "x86_64-linux";
      overlay-stable = _: _: {
        unstable = import nixos-unstable {
          inherit system;
        };
      };

    in {
      nixosConfigurations = {
        ginnungagap = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
            nixos-hardware.nixosModules.common-cpu-intel-cpu-only
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-pc
            ./machines/ginnungagap
          ];
        };
        centimanus = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
            ./machines/centimanus
          ];
        };
        thrud = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            ./machines/thrud
          ];
        };
      };
    };
}
