{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixos-unstable, nixos-hardware }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixos-unstable { inherit system; };
      defaults = { pkgs, ... }: {
        system.configurationRevision = self.rev or self.dirtyRev or "dirty";
        nixpkgs.overlays = [
          (final: prev: {
            qutebrowser = unstable.qutebrowser;
            mpv-unwrapped = unstable.mpv-unwrapped; # need for mpv
            wrapMpv = unstable.wrapMpv; # need for mpv
            yt-dlp = unstable.yt-dlp;
            telegram-desktop = unstable.telegram-desktop;
          })
        ];
        nix.registry = builtins.mapAttrs (k: v: {
          to = {
            type = "path";
            path = v.outPath;
          };
        }) (builtins.removeAttrs inputs [ "self" ]);
      };
      filterDirs = nixpkgs.lib.attrsets.filterAttrs (k: v: v == "directory");
      machines = filterDirs (builtins.readDir ./machines);
      configurateMachine = k: v: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit nixos-hardware; };
        modules = [
          defaults
          ./machines/${k}
        ];
      };

    in {
      nixosConfigurations = builtins.mapAttrs configurateMachine machines;
    };
}
