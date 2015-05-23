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
    wireless.enable = true;
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
    bash bashCompletion
    git
    wget
    xsel xclip
    vim_configurable
    htop
    skype firefoxWrapper thunderbird
    iotop
    stdenv
    zathura
    gcc gnumake cmake
    trayer xscreensaver
    rxvt_unicode urxvt_perls urxvt_tabbedex
    pmutils
    lsof
    xlibs.xhost unclutter hsetroot
    ffmpeg
    smartmontools pulseaudio pciutils libreoffice pavucontrol truecrypt vifm vlc
    dmenu gparted nox trayer
  ];

  services = {
    openssh.enable = true;
    ntp.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    virtualboxHost.enable = true;
  };

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
  };

  services.xserver = {
    enable = true;
    # layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";

    videoDrivers = [ "nvidia" ];

    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.slim.enable = true;

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
    fontconfig.enable = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.defaultFonts.monospace = ["Terminus"];
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      terminus_font
      ttf_bitstream_vera
    ];
  };
}

