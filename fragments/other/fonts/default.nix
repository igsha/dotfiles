{ pkgs, lib, ... }:

let

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
    enableDefaultPackages = true;
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
  };
}
