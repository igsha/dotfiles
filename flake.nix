{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixos-hardware.url = "nixos-hardware";
    nixos-unstable.url = "nixpkgs/nixos-unstable";
    nixos-2305.url = "nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, nixos-unstable, nixos-hardware, nixos-2305 }:
    let
      system = "x86_64-linux";
      overlays = _: _: {
        unstable = import nixos-unstable { inherit system; };
        rocketchat-desktop = (import nixos-2305 { inherit system; }).rocketchat-desktop;
      };

    in {
      nixosConfigurations = {
        ginnungagap = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
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
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
            nixos-hardware.nixosModules.common-cpu-intel-cpu-only
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-pc
            ./machines/centimanus
          ];
        };
        thrud = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
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
