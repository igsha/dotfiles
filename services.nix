{ pkgs }:

{
  xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 20;
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
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys";
    layout = "us,ru";

    xautolock = {
      enable = true;
      enableNotifier = true;
      extraOptions = [ "-detectsleep" ];
      notifier = "${pkgs.libnotify}/bin/notify-send \"Locking in 10 seconds\"";
      time = 10;
      killer = "${pkgs.systemd}/bin/systemctl suspend";
      killtime = 30;
      locker = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
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
    backend = "xr_glx_hybrid";
  };

  actkbd.enable = true;

  rogue.enable = true;

  logind.extraConfig = ''
    #IdleAction=suspend
    #IdleActionSec=20min
    HandlePowerKey=suspend
  '';

  unclutter-xfixes.enable = true;

  smartd.notifications = {
    enable = true;
    x11.enable = true;
  };

  kmscon.enable = true;

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

  jupyter = {
    enable = true;
    password = "'sha1:66226798cbb5:552e68bea700ec46fee4d72375d0b4e554893f5d'";
    kernels = {
      python3 = let
        env = ((pkgs.python3.overrideAttrs (old: rec {
          propagatedNativeBuildInputs = old.propagatedNativeBuildInputs ++ [ pkgs.graphviz ];
        })).withPackages (pp: with pp; [
          ipykernel
          pandas
          (scikitlearn.overridePythonAttrs (x: rec { doCheck = false; }))
          scipy
          matplotlib
          opencv3
          pillow
        ]));
      in {
        displayName = "Python 3 for machine learning";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "--pylab=inline"
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
