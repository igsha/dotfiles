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
  services = {
    hypridle.enable = true;
    xserver.desktopManager.runXdgAutostartIfNone = true;
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

  # TODO: https://github.com/Alexays/Waybar/issues/5224
  # TODO: https://github.com/Alexays/Waybar/issues/1373
  systemd.user.services.waybar.serviceConfig = {
    ExecStart = [
      "" # Reset old command
      "${pkgs.bash}/bin/bash -c '${pkgs.waybar}/bin/waybar 2>&1 | ${pkgs.gnugrep}/bin/grep --line-buffered -v GTK_IS_ACCEL_GROUP'"
    ];
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
      grim
      satty
      hyprprop
      slurp
    ];
    etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
  };
}
