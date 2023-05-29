{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = true;
    autoRepeatDelay = 250;
    autoRepeatInterval = 40;
    enableTCP = true;
    wacom.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };
    xkbOptions = "grp:alt_space_toggle,grp:sclk_toggle,keypad:pointerkeys";
    layout = "us,ru";
    serverFlagsSection = ''
      Option "BlankTime" "0"
    '';
    monitorSection = ''
      Option "DPMS" "false"
    '';
    exportConfiguration = true;
    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [
    numlockx
    evtest
    xf86_input_wacom
    libwacom
    wacomtablet
  ];
}
