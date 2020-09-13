# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, options, ... }:

let
  overlay = let my-packages = /etc/nix-overlays; in
    if builtins.pathExists my-packages then my-packages
    else builtins.fetchTarball https://api.github.com/repos/igsha/nix-overlays/tarball/master;
  overlay-compat = builtins.toPath ./overlays.nix;

in {
  imports = [
    "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ] ++ (import "${overlay}/modules/module-list.nix");

  nixpkgs.config = import ./nixpkgs-config.nix;
  nixpkgs.overlays = [ (import overlay) ];
  nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=${overlay-compat}" ];

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
    firewall.allowedTCPPorts = [ 22 80 8080 8888 4200 ];
    wireless.iwd.enable = true;
  };

  console = {
    useXkbConfig = true;
    font = "LatArCyrHeb-16";
  };

  sound.mediaKeys.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  time.timeZone = "Europe/Moscow";

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
