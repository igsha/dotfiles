{ pkgs, ... }:

let
  nvimCmd = pkgs.writeScript "nvim-desktop.sh" ''
    #!/usr/bin/env sh
    $TERMINAL --class editor -e nvim "$1"
  '';
  customVim = (pkgs.neovim.override {
    configure = import ./vimrcConfig.nix { inherit (pkgs) vimUtils vimPlugins fetchFromGitHub python3Packages; };
  }).overrideAttrs (old: rec {
    buildCommand = old.buildCommand + ''
      substitute $out/share/applications/nvim.desktop $out/share/applications/nvim.desktop \
        --replace 'Exec=nvim' "Exec=${nvimCmd} %U"
    '';
  });

in {
  environment.systemPackages = [ customVim ];
}
