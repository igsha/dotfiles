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
    ];
    extraSessionCommands = ''
      systemctl --user stop graphical-session.target graphical-session-pre.target
      systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID
      systemctl --user start graphical-session-pre.target
    '';
  };

  home-config.sway = {
    packages = [ "sway" ];
    dir = builtins.toString ./home-config;
  };
}
