{ pkgs, ... }:

{
  services.hypridle.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  programs = {
    hyprlock.enable = true;
    waybar.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  home-config.hyprland = ./home-config;

  environment = {
    systemPackages = with pkgs; [
      rofi
      wayland-utils
      wlvncc
      wlay
      wdisplays
      wlr-randr
      wl-clipboard
      waybar
      hyprland-per-window-layout
      wttrbar
      rose-pine-hyprcursor
      rose-pine-cursor
    ];
    etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
  };
}
