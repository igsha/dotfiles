{ pkgs, ... }:

{
  services.hypridle.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  programs = {
    hyprlock.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
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
      waybar
      hyprland-per-window-layout
    ];
    etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
  };
}
