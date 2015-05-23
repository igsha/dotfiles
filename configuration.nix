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
    firefox = {
      enableAdobeFlash = true;
    };
  };

  environment.systemPackages = with pkgs; [
    python
    git
    wget
    xsel xclip
    vim_configurable
    htop
    skype firefoxWrapper thunderbird
    iotop
    stdenv
    zathura
    gcc gnumake cmake wget
    trayer xscreensaver
    rxvt_unicode urxvt_perls urxvt_tabbedex
    lsof
    xlibs.xhost unclutter hsetroot
    ffmpeg
    smartmontools pulseaudio pciutils libreoffice pavucontrol truecrypt vifm vlc
    dmenu gparted nox trayer
    ctags
    bashInteractive bashCompletion utillinuxCurses freetype fuse pwgen
    gitAndTools.gitSVN
    gitAndTools.gitflow
    wpa_supplicant_gui
    xfontsel
  ];

  services = {
    openssh.enable = true;
    ntp.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    virtualboxHost.enable = true;
  };

  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    pulseaudio.systemWide = true;
  };

  services.xserver = {
    enable = true;
    # layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";

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
      theme = pkgs.slimThemes.nixosSlim;
    };

    windowManager = {
      default = "xmonad";
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = self: [
          self.xmonad
          self.xmobar
          self.MissingH
        ];
      };
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

  security.sudo.enable = true;
}

