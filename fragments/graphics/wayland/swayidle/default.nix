{ pkgs, ... }:

let
  notifier = "${pkgs.libnotify}/bin/notify-send -t 9000 Lock \"Locking in 10 seconds...\"";
  locker = "${pkgs.swaylock}/bin/swaylock -f";

in {
  environment.systemPackages = with pkgs; [ swayidle libnotify swaylock ];

  systemd.user.services.swayidle = {
    wantedBy = [ "graphical-session.target" ];
    description = "Idle manager for Wayland";
    serviceConfig = {
      ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 590 '${notifier}' timeout 600 '${locker}' timeout 5400 'systemctl suspend' before-sleep '${locker}' lock '${locker}'";
      Type = "simple";
    };
  };
}
