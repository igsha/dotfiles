{ config, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    timesyncd.enable = true;
    printing.enable = true;
    atd.enable = true;
    geoclue2.enable = true;
    actkbd.enable = true;
    flatpak.enable = true;
    davfs2.enable = true;
    unclutter-xfixes.enable = config.services.xserver.enable;

    journald.extraConfig = "SystemMaxUse=4G";

    logind = {
      killUserProcesses = true;
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };
  };

  location.provider = "geoclue2";
}
