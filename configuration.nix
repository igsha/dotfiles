# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, ... }:

{
  imports = [
    "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ];

  nixpkgs.config = import ./nixpkgs-config.nix;
  services = import ./services.nix { pkgs = pkgs; };
  fonts = import ./fonts.nix { pkgs = pkgs; };
  hardware = import ./hardware.nix { pkgs = pkgs; };
  programs = import ./programs.nix { pkgs = pkgs; };

  environment = {
    etc = {
      "fuse.conf".text = ''
        user_allow_other
      '';
    };
    systemPackages = import ./packages.nix { pkgs = pkgs; };
  };

  boot.loader = {
    grub.device = "/dev/sda";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-pc";
    firewall.allowedTCPPorts = [ 22 80 8080 8888 4200 ];
    wireless.iwd.enable = true;
  };

  i18n = {
    consoleUseXkbConfig = true;
    consoleFont = "LatArCyrHeb-16";
  };

  sound.mediaKeys.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  time.timeZone = "Europe/Moscow";

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

  system = {
    stateVersion = "unstable";
    autoUpgrade = {
      enable = false;
      dates = "Fri 20:00";
    };
  };
}
