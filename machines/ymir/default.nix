{ pkgs, ... }:

{
  imports = [
    <nixos-hardware/raspberry-pi/4>
    ../../home-config
    ../../fragments/other
    ../../fragments/other/sound
    ../../fragments/other/fonts
    ../../fragments/services
    ../../fragments/programs/neovim
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import (builtins.fetchTarball https://api.github.com/repos/igsha/nix-overlays/tarball/master))
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    tmpOnTmpfs = true;
    initrd.availableKernelModules = [ "xhci_pci" ];
    kernelParams = [ "8250.nr_uarts=1" "console=ttyS0,115200" "console=tty0" ];
    consoleLogLevel = 6;
    loader = {
      raspberryPi = {
        enable = false;
        version = 4;
      };
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "ymir";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (libcec.override { withLibraspberrypi = true; })
    mpv
    git
    chromium
    yt-dlp
    lshw
    pciutils
    networkmanager
    glxinfo
  ];

  home-config.root = {
    packages = [ "mpv" ];
    dir = builtins.toString ./home-config;
  };

  services = {
    openssh.enable = true;
    ntp.enable = true;
    udev.extraRules = ''
      # allow access to raspi cec device for video group (and optionally register it as a systemd device, used below)
      SUBSYSTEM=="vchiq", GROUP="video", MODE="0660", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/vchiq"
    '';
  };

  users = {
    mutableUsers = false;
    users.nixos = {
      isNormalUser = true;
      hashedPassword = "$6$8e6D8ywa6JU3hklL$JczQ2nIMUX4WKVGkdou4vpZWIK.NQIWX7VfrrSma9TvsjJm3sYNVWviIoAzX6eqUAZe/rkpdjv1nKT3p.OQG1.";
      extraGroups = [ "wheel" "video" "networkmanager" "audio" ];
    };
  };

  # Enable GPU acceleration
  hardware.raspberry-pi."4" = {
    fkms-3d = {
      enable = true;
      cma = 512;
    };
    audio.enable = true;
    dwc2.enable = false;
    apply-overlays-dtmerge.enable = true;
    i2c0.enable = true;
    i2c1.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "nixos";
      };
    };
    desktopManager.xfce.enable = true;
  };

  /*systemd.sockets."cec-client" = {
    after = [ "dev-vchiq.device" ];
    bindsTo = [ "dev-vchiq.device" ];
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenFIFO = "/run/cec.fifo";
      SocketGroup = "video";
      SocketMode = "0660";
    };
  };
  systemd.services."cec-client" = {
    after = [ "dev-vchiq.device" ];
    bindsTo = [ "dev-vchiq.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.libcec}/bin/cec-client -d 1'';
      ExecStop = ''/bin/sh -c "echo q > /run/cec.fifo"'';
      StandardInput = "socket";
      StandardOutput = "journal";
      Restart = "no";
    };
  };*/
}
