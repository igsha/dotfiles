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

  home-config.hyprland = {
    packages = [ "hyprland" ];
    dir = builtins.toString ./home-config;
  };

  environment = {
    systemPackages = with pkgs; [
      rofi-wayland
      wayland-utils
      wlvncc
      wlay
      wdisplays
      wlr-randr
      wl-clipboard
      waybar
      hyprland-per-window-layout
      wttrbar
    ];
    etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
  };
}
