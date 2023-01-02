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
  };

  home-config.x11 = {
    packages = [ "sx" ];
    dir = builtins.toString ./home-config;
  };

  environment.systemPackages = with pkgs; [
    numlockx
    evtest
    xf86_input_wacom
    libwacom
    wacomtablet
  ];
}
