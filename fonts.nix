{ pkgs }:

{
  fontDir.enable = true;
  enableGhostscriptFonts = true;
  fontconfig = {
    enable = true;
    defaultFonts.emoji = [ "Font Awesome 5 Free" "Font Awesome 5 Brands" ];
    allowBitmaps = false;
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
    font-awesome
    powerline-fonts
    powerline-symbols
    symbola
  ];
}
