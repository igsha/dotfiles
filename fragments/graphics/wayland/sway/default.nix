{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaybg
      foot
      mako
      swaykbdd
      sway-contrib.grimshot
      wl-clipboard
      ponymix
      wayvnc
    ];
  };

  systemd.user.targets.sway-session = {
    description = "sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target"];
    after = [ "graphical-session-pre.target" ];
    before = [ "xdg-desktop-autostart.target" ];
  };

  home-config.sway = {
    packages = [ "sway" ];
    dir = builtins.toString ./home-config;
  };
}
