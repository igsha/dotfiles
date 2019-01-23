{ config, pkgs, lib, ... }:

rec {

  services.xserver = {
    enable = true;

    autoRepeatDelay = 300;
    autoRepeatInterval = 20;
    enableTCP = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableCoreFonts = true;
    fontconfig = {
      defaultFonts.monospace = ["DejaVu Sans Mono"];
      antialias = true;
    };
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      ttf_bitstream_vera
      inconsolata-lgc
      google-fonts
      anonymousPro
      font-awesome-ttf
      powerline-fonts
    ];
  };
}
