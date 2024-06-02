{ config, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    timesyncd.enable = true;
    printing.enable = true;
    atd.enable = true;
    geoclue2.enable = true;
    flatpak.enable = true;
    davfs2.enable = true;
    unclutter-xfixes.enable = config.services.xserver.enable;
    cron.enable = true;

    journald.extraConfig = "SystemMaxUse=4G";

    logind = {
      killUserProcesses = true;
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };
  };

  location.provider = "geoclue2";
}
