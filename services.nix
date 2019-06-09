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
    tor = {
      enable = true;
      client.enable = true;
    };
    atd.enable = true;
    polipo.enable = true;
    journald.extraConfig = "SystemMaxUse=4G";
    geoclue2.enable = true;
    compton = {
      enable = true;
      vSync = true;
      # https://github.com/chjj/compton/issues/152
      extraOptions = ''
        xrender-sync = true
        xrender-sync-fence = true
      '';
      backend = "xr_glx_hybrid";
    };
    actkbd.enable = true;
    rogue.enable = true;
    logind.extraConfig = ''
      IdleAction=suspend
      IdleActionSec=3600
      HandlePowerKey=suspend
    '';
    unclutter-xfixes.enable = true;
    smartd.notifications = {
      enable = true;
      x11.enable = true;
    };
    kmscon.enable = true;
    shellinabox.enable = true;
    gnome3.gnome-keyring.enable = true;
    dbus.packages = [ pkgs.gnome3.dconf ];
    taskserver = {
      enable = true;
      fqdn = "nixos-pc";
      listenHost = "::";
    };
    redshift = {
      enable = true;
      provider = "geoclue2";
    };
  };
}
