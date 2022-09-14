{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = false;
    autoRepeatDelay = 250;
    autoRepeatInterval = 40;
    enableTCP = true;
    wacom.enable = true;
    serverFlagsSection = ''
      Option "BlankTime" "0"
    '';
    monitorSection = ''
      Option "DPMS" "false"
    '';
    exportConfiguration = true;
    displayManager.sx.enable = true;
    videoDrivers = [ "nvidia" "nouveau" ];
    xautolock = rec {
      enable = true;
      time = 20;
      notify = 10;
      notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
      locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -- ${pkgs.maim}/bin/maim";
      nowlocker = locker;
    };
  };

  home-config.x11 = {
    packages = [ "sx" ];
    dir = builtins.toString ./home-config;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl pipewire ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiVdpau libvdpau-va-gl pipewire ];
    };
    nvidia = {
      open = false;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    };
  };

  environment.systemPackages = with pkgs; [
    evtest
    xf86_input_wacom
    libwacom
    wacomtablet
  ];
}
