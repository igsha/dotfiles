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
    stdenv
    git
    wget
    xsel xclip
    vim
    htop
    iotop
    trayer xscreensaver
    urxvt_perls urxvt_tabbedex rxvt_unicode-with-plugins
    lsof
    xlibs.xhost unclutter hsetroot
    dmenu nox
    wpa_supplicant_gui
    xfontsel
    manpages
    stdmanpages
  ];

  services = {
    openssh.enable = true;
    ntp.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    virtualboxHost.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = true;
      systemWide = true;
    };
  };

  services.xserver = {
    autorun = true;
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
  programs.bash.enableCompletion = true;
}

