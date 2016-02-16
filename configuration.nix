# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    grub.device = "/dev/sda";
    gummiboot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "igor-pc";
    wireless = {
      enable = true;
      interfaces = ["wlp6s0"];
      userControlled.enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    virtualbox.enableExtensionPack = true;
  };

  environment.systemPackages = with pkgs; [
    stdenv
    git
    wget
    xsel xclip
    vim
    htop
    iotop
    xscreensaver
    urxvt_perls urxvt_tabbedex rxvt_unicode-with-plugins
    lsof
    xlibs.xhost unclutter hsetroot
    dmenu nox
    wpa_supplicant_gui
    xfontsel
    manpages
    stdmanpages
    xkb_switch
    inetutils
    which
    python34Packages.i3pystatus
  ];

  services = {
    openssh.enable = true;
    ntp.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    tor.enable = true;
    atd.enable = true;
    redshift = {
      enable = true;
      latitude = "55.749792";
      longitude = "37.6324949";
    };
    polipo = {
      enable = true;
      socksParentProxy = "localhost:9050";
    };
  };

  virtualisation = {
    virtualbox.host.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
    };
    pulseaudio = {
      enable = true;
      systemWide = true;
      support32Bit = true;
    };
  };

  services.xserver = {
    autorun = true;
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys";

    videoDrivers = [ "nvidia" ];
    vaapiDrivers = [ pkgs.vaapiVdpau ];

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    displayManager.slim = {
      enable = true;
      defaultUser = "igor";
      autoLogin = true;
    };

    windowManager = {
      default = "i3";
      i3.enable = true;
    };
  };

  time.timeZone = "Europe/Moscow";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableCoreFonts = true;
    fontconfig.defaultFonts.monospace = ["Terminus"];
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      terminus_font
      ttf_bitstream_vera
    ];
  };

  programs.bash.enableCompletion = true;

  systemd.coredump = {
    enable = true;
    extraConfig = "Storage=external";
  };

  security = {
    sudo.enable = true;
    pam.loginLimits = [
      { domain = "*"; type = "hard"; item = "core"; value = "unlimited"; }
      { domain = "*"; type = "soft"; item = "core"; value = "unlimited"; }
    ];
    polkit.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "08:00";
  };
  nix.extraOptions = ''
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';
}

