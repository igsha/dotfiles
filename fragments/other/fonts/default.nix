{ pkgs, lib, ... }:

let
  packages = with pkgs; [
    corefonts
    ttf_bitstream_vera
    inconsolata-lgc
    google-fonts
    anonymousPro
    font-awesome
    powerline-fonts
    powerline-symbols
    symbola
    line-awesome
    nerdfonts
  ];

in {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Font Awesome 6 Free" "Font Awesome 6 Brands" "Noto Color Emoji" ];
      allowBitmaps = false;
      antialias = true;
    };
  } // (if lib.versionAtLeast pkgs.lib.version "23.11" then {
    enableDefaultPackages = true;
    inherit packages;
  } else {
    enableDefaultFonts = true;
    fonts = packages;
  });
}
