{ pkgs, ... }:

let
  wttrbar-sh = pkgs.writeShellApplication {
    name = "wttrbar.sh";
    runtimeInputs = with pkgs; [
      httpie
      jq
      jo
      which
    ];
    text = builtins.readFile ./wttrbar.sh;
  };

in {
  services.hypridle.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  systemd.services = {
    "getty@tty2" = {
      enable = true;
      wantedBy = [ "getty.target" ];
    };
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  programs = {
    hyprlock.enable = true;
    waybar.enable = true;
    wayvnc.enable = true;
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
      wdisplays
      wlr-randr
      wl-clipboard
      waybar
      hyprland-per-window-layout
      rose-pine-hyprcursor
      rose-pine-cursor
      wttrbar-sh
    ];
    etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
  };
}
