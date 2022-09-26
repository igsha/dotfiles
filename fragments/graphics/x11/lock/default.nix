{ pkgs, ... }:

let
  locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -- ${pkgs.maim}/bin/maim";

in {
  services.xserver.xautolock = {
    enable = true;
    time = 20;
    notify = 10;
    notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
    inherit locker;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = locker;
    extraOptions = [ "--ignore-sleep" ];
  };
}
