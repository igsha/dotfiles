{ pkgs, ... }:

{
  systemd.user = {
    services.random-background = {
      enable = true;
      description = "Set random desktop background using feh";
      after = [ "graphical-session-pre.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.feh}/bin/feh --recursive --bg-fill --randomize \${HOME}/Pictures";
        Type = "oneshot";
      };
    };

    timers.random-background = {
      enable = true;
      description = "Set random desktop background using feh";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnUnitActiveSec = "2hours";
      };
    };
  };
}
