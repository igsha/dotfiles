{ pkgs, ... }:

{
  services.offlineimap = {
    enable = true;
    path = with pkgs; [ pass ];
    install = true;
    onCalendar = "*:0/5";
    timeoutStartSec = "120sec";
  };

  environment.systemPackages = with pkgs; [
    msmtp
    mblaze
  ];
}
