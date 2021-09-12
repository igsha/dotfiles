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
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys,compose:shift_paus";
    layout = "us,ru";

    xautolock = {
      enable = true;
      enableNotifier = true;
      extraOptions = [ "-detectsleep" ];
      notifier = "${pkgs.libnotify}/bin/notify-send \"Locking in 10 seconds\"";
      time = 20;
      locker = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
    };

    displayManager = {
      autoLogin.enable = false;
    };

    windowManager = {
      i3 = {
        enable = true;
        configFile = builtins.toPath ./templates/i3.conf;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [ i3blocks-gaps dmenu xkb-switch metar ];
        extraSessionCommands = ''
          ${pkgs.numlockx}/bin/numlockx
          export I3BLOCKS_DIR=${pkgs.i3blocks-gaps}/libexec/i3blocks
          export I3BLOCKS_CONF_DIR=${builtins.dirOf (builtins.toPath ./templates/i3blocks.conf)}
          ${pkgs.xss-lock}/bin/xss-lock -l -- ${pkgs.i3lock-fancy}/bin/i3lock-fancy -- ${pkgs.maim}/bin/maim &
          ${pkgs.xorg.setxkbmap}/bin/setxkbmap
          ${pkgs.systemd}/bin/systemctl import-environment --user XDG_SESSION_ID
          ${pkgs.systemd}/bin/systemctl restart --user xautolock.service
        '';
      };
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

  kmscon.enable = true;
  gnome.gnome-keyring.enable = true;
  openntpd.enable = true;
  printing.enable = true;
  atd.enable = true;
  geoclue2.enable = true;
  actkbd.enable = true;
  unclutter-xfixes.enable = true;
  redshift.enable = true;
  flatpak.enable = true;
  davfs2.enable = true;
  pipewire.enable = true;

  tor = {
    enable = true;
    client.enable = true;
  };

  journald.extraConfig = "SystemMaxUse=4G";

  picom = {
    enable = true;
    vSync = true;
    backend = "xrender";
    settings = {
      unredir-if-possible = false;
    };
  };

  logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=120min
    HandlePowerKey=suspend
  '';

  smartd.notifications = {
    x11.enable = true;
    wall.enable = true;
  };

  dbus.packages = [ pkgs.gnome3.dconf ];

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
          opencv3
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
