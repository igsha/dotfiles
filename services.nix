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
      time = 10;
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
  gnome3.gnome-keyring.enable = true;
  openntpd.enable = true;
  printing.enable = true;
  nixosManual.showManual = true;
  atd.enable = true;
  geoclue2.enable = true;
  actkbd.enable = true;
  unclutter-xfixes.enable = true;
  redshift.enable = true;
  flatpak.enable = true;

  tor = {
    enable = true;
    client.enable = true;
  };

  journald.extraConfig = "SystemMaxUse=4G";

  compton = {
    enable = true;
    vSync = true;
    backend = "xr_glx_hybrid";
  };

  logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=40min
    HandlePowerKey=suspend
  '';

  smartd.notifications = {
    enable = true;
    x11.enable = true;
  };

  dbus.packages = [ pkgs.gnome3.dconf ];

  jupyter = {
    enable = true;
    password = "'sha1:66226798cbb5:552e68bea700ec46fee4d72375d0b4e554893f5d'";
    group = "users";
    kernels = {
      python3 = let
        env = (pkgs.python3.buildEnv.override {
          extraLibs = [
            pkgs.pandoc
            pkgs.texlive.combined.scheme-small
          ];
        }).withPackages (pp: with pp; [
          ipykernel
          pandas
          scikitlearn
          scikitimage
          scipy
          matplotlib
          numpy
          opencv3
          pillow
          python-gitlab
        ]);
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
