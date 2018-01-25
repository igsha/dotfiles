# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./user-services.nix
    ./services.nix
    ./xserver.nix
    ./nixpkgs/langenv.nix
  ];

  boot.loader = {
    grub.device = "/dev/sda";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixos-pc";
    networkmanager.enable = true;
    connman = {
      enable = false;
      enableVPN = true;
    };
    wireless = {
      enable = false;
      networks = {
        SomeNetwork = {
          psk = "SomePassword";
        };
      };
      userControlled.enable = true;
    };
  };

  i18n = {
    consoleUseXkbConfig = true;
    consoleFont = "LatArCyrHeb-16";
  };

  sound.mediaKeys.enable = true;

  virtualisation = {
    virtualbox.host.enable = false;
    libvirtd.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
      extraPackages = [ pkgs.vaapiVdpau ];
    };
    pulseaudio = {
      enable = true;
      systemWide = true;
      support32Bit = true;
      daemon.config = {
        flat-volumes = "no";
      };
    };
  };

  time.timeZone = "Europe/Moscow";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableCoreFonts = true;
    fontconfig = {
      defaultFonts.monospace = ["DejaVu Sans Mono"];
      antialias = true;
    };
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      ttf_bitstream_vera
      inconsolata-lgc
      google-fonts
      anonymousPro
    ];
  };

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

  nix = {
    gc = {
      automatic = true;
      dates = "Fri 20:00";
    };
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
  };

  system.autoUpgrade = {
    enable = false;
    dates = "Fri 20:00";
  };

  programs.bash = {
    enableCompletion = true;
    shellAliases = {
      ls = "ls -h --color";
      "ls.pure" = "`which ls`";
      la = "ls -lta";
      ll = "ls -lt";
      grep = "grep --color";
      cal = "cal -m3";
      df = "df -h";
      wineru = "LC_ALL=ru_RU.UTF-8 wine";
      wineru64 = "WINEARCH=win64 WINEPREFIX=~/.wine64 wineru";
      fix = "TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1)) && eval $TF_CMD && history -s $TF_CMD";
    };
    loginShellInit = ''
      export HISTCONTROL=ignoredups
      unset SSH_ASKPASS
      export EDITOR=nvim
      export BROWSER=qutebrowser
      export PDFVIEWER=zathura
      export PSVIEWER=$PDFVIEWER
      export DVIVIEWER=$PDFVIEWER
      export TERMINAL=urxvtc
    '';
  };
}
