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
          specialArgs = { inherit nixos-hardware; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
            ./machines/ginnungagap
          ];
        };
        centimanus = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
            ./machines/centimanus
          ];
        };
        thrud = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlays ]; })
            ./machines/thrud
          ];
        };
      };
    };
}
