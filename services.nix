{ config, pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
      extraConfig = ''
        AllowTcpForwarding yes
        TCPKeepAlive yes
        PermitTunnel yes
      '';
    };
    openntpd.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    tor.enable = true;
    atd.enable = true;
    redshift = {
      enable = true;
      latitude = "55.749792";
      longitude = "37.6324949";
    };
    polipo.enable = true;
    journald.extraConfig = "SystemMaxUse=4G";
    geoclue2.enable = true;
    teamviewer.enable = false;
    urxvtd.enable = true;
    compton = {
      enable = false;
      vSync = "opengl";
      # https://github.com/chjj/compton/issues/152
      extraOptions = ''
        xrender-sync = true
        xrender-sync-fence = true
      '';
    };
    actkbd.enable = true;
    rogue.enable = true;
    logind.extraConfig = ''
      IdleAction=suspend
      IdleActionSec=1800
      HandlePowerKey=suspend
    '';
    xbanish.enable = true;
    smartd.notifications = {
      enable = true;
      x11.enable = true;
    };
  };
}
