{ pkgs }:

{
  gnome.gnome-keyring.enable = true;
  timesyncd.enable = true;
  printing.enable = true;
  atd.enable = true;
  geoclue2.enable = true;
  actkbd.enable = true;
  flatpak.enable = true;
  davfs2.enable = true;
  unclutter-xfixes.enable = true;
  redshift.enable = false;

  xserver = {
    enable = true;
    autorun = false;
    autoRepeatDelay = 250;
    autoRepeatInterval = 40;
    enableTCP = true;
    wacom.enable = true;
    serverFlagsSection = ''
      Option "BlankTime" "0"
    '';
    monitorSection = ''
      Option "DPMS" "false"
    '';
    exportConfiguration = true;
    useGlamor = true;
    displayManager = {
      sx.enable = true;
    };
  };

  openssh = {
    enable = true;
    forwardX11 = true;
    extraConfig = ''
      AllowTcpForwarding yes
      TCPKeepAlive yes
      PermitTunnel yes
    '';
  };

  pipewire = {
    enable = false;
    pulse.enable = true;
  };

  tor = {
    enable = true;
    client.enable = true;
  };

  journald.extraConfig = "SystemMaxUse=4G";

  logind = {
    killUserProcesses = true;
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

  smartd.notifications = {
    x11.enable = true;
    wall.enable = true;
  };

  dbus.packages = [ pkgs.dconf ];

  jupyterhub = {
    enable = true;
    port = 8888;
    kernels = {
      python3 = let
        env = pkgs.python3.withPackages (pp: with pp; [
          ipykernel
          pandas
          scikitlearn
          scikitimage
          scipy
          matplotlib
          numpy
          tensorflow
          opencv4
          pillow
          python-gitlab
          bitstring
          sympy
        ]);
      in {
        displayName = "Python3";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };
}
