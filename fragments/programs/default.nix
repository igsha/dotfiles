{ pkgs, ... }:

{
  programs = {
    command-not-found.enable = true;
    system-config-printer.enable = true;
    less = {
      enable = true;
      envVariables = {
        LESS = "-R";
      };
    };
    evolution.enable = true;
    fuse.userAllowOther = true;
    starship.enable = true;
    udevil.enable = true;
    adb.enable = true;
    steam.enable = true;
    dconf.enable = true;
  };

  services = {
    dbus.packages = [ pkgs.dconf ];
  };
}
