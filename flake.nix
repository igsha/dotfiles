{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixos-hardware.url = "nixos-hardware";
    nixos-unstable.url = "nixpkgs/nixos-unstable";
    nixos-2305.url = "nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, nixos-unstable, nixos-hardware, nixos-2305 }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixos-unstable {
        inherit system;
        overlays = [
          (_: prev: {
            qutebrowser = prev.qutebrowser.override { enableVulkan = false; };
            yt-dlp = prev.yt-dlp.overridePythonAttrs (old: rec {
              propagatedBuildInputs = old.propagatedBuildInputs ++ [ prev.python3Packages.lxml ];
              postPatch = ''
                cp ${./fragments/packages/user_extractors.py} yt_dlp/extractor/user_extractors.py
                echo "from .user_extractors import *" >> yt_dlp/extractor/_extractors.py
              '';
            });
          })
        ];
      };
      defaults = { pkgs, ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            rocketchat-desktop = (import nixos-2305 { inherit system; }).rocketchat-desktop;
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

    in {
      nixosConfigurations = {
        ginnungagap = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware; };
          modules = [
            defaults
            ./machines/ginnungagap
          ];
        };
        centimanus = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware; };
          modules = [
            defaults
            ./machines/centimanus
          ];
        };
        thrud = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware; };
          modules = [
            defaults
            ./machines/thrud
          ];
        };
      };
    };
}
