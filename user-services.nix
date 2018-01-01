{config, pkgs, ...}:

let
  oneshot = { execute, type ? "simple", ... }@args: {
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = type;
      RemainAfterExit = "yes";
      ExecStart = execute;
      PassEnvironment = "DISPLAY";
    };
  } // removeAttrs args [ "execute" "type" ];

in {
  systemd.user.services = {
    dropboxd = {
      description = "Dropbox daemon";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.dropbox-cli}/bin/dropbox start";
        ExecStop = "${pkgs.dropbox-cli}/bin/dropbox stop";
      };
    };

    xscreensaver = oneshot {
      description = "Xscreensaver - screen savers";
      execute = "${pkgs.xscreensaver}/bin/xscreensaver -no-splash";
    };

    dunst = oneshot {
      description = "dunst - notification daemon";
      execute = "${pkgs.dunst}/bin/dunst";
    };

    setxkbmap = oneshot {
      description = "setxkbmap - activate layout changing";
      execute = "${pkgs.xorg.setxkbmap}/bin/setxkbmap";
    };
  };

  environment.systemPackages = with pkgs; [
    dropbox-cli
    xscreensaver
    dunst libnotify
    xorg.setxkbmap
  ];
}
