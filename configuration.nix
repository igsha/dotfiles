# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, options, ... }:

let
  overlay = let my-packages = /etc/nix-overlays; in
    if builtins.pathExists my-packages then my-packages
    else builtins.fetchTarball https://api.github.com/repos/igsha/nix-overlays/tarball/master;
  overlay-compat = ./overlays.nix;

in {
  # nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  imports = [ (import <home-manager> {}).nixos ] ++ (import "${overlay}/modules/module-list.nix");

  nixpkgs = {
    config = {
      allowUnfree = true;
      virtualbox.host.enableExtensionPack = true;
      allowTexliveBuilds = true;
      pulseaudio = true;
      android_sdk.accept_license = true;
      zathura.useMupdf = false;
    };
    overlays = [ (import overlay) ];
  };

  nix = {
    settings.sandbox = true;
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    #nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=${overlay-compat}" ];
  };

  services = import ./services.nix { pkgs = pkgs; };
  fonts = import ./fonts.nix { pkgs = pkgs; };
  hardware = import ./hardware.nix { pkgs = pkgs; };
  programs = import ./programs.nix { pkgs = pkgs; };
  xdg.portal.enable = true;

  environment = {
    etc = {
      "fuse.conf".text = ''
        user_allow_other
      '';
    };
    systemPackages = import ./packages.nix { pkgs = pkgs; };
    homeBinInPath = true;
  };

  location = {
    provider = "geoclue2";
  };

  boot.loader = {
    grub.device = "/dev/sda";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-pc";
    firewall.allowedTCPPorts = [ 22 80 8080 8888 4200 8554 1935 ];
    wireless.iwd.enable = true;
  };

  console = {
    useXkbConfig = true;
    font = "LatArCyrHeb-16";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  time.timeZone = "Europe/Moscow";

  security = {
    sudo.enable = true;
    pam = {
      loginLimits = [
        { domain = "*"; type = "hard"; item = "core"; value = "unlimited"; }
        { domain = "*"; type = "soft"; item = "core"; value = "unlimited"; }
      ];
      services.swaylock = {};
    };
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
