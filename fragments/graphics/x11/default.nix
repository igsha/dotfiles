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
    numlockx
    evtest
    xf86_input_wacom
    libwacom
    wacomtablet
  ];
}
