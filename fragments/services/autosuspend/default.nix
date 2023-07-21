{ pkgs, config, lib, ... }:

let
  timeout = 1200;
  check-time-interval = pkgs.writeShellApplication {
    name = "check-time-interval.sh";
    runtimeInputs = with pkgs; [ coreutils ];
    text = ''
      test "$(date +%H)" -ge 11 -a "$(date +%H)" -le 12
    '';
  };

in {
  services = {
    autosuspend = {
      enable = true;
      settings = {
        interval = 300;
        idle_time = timeout;
      };
      checks = {
        Users.host = "\\d{1,3}(\\.\\d{1,3}){3}";
        Load.threshold = 0.5;
        LogindSessionsIdle.enabled = true;
        ExternalCommand.command = "${check-time-interval}/bin/check-time-interval.sh";
      } // lib.optionalAttrs config.services.xserver.enable {
        XIdleTime = {
          inherit timeout;
          method = if config.services.xserver.autorun then "logind" else "sockets";
        };
      };
      wakeups = {
        File.path = "/var/run/autosuspend/wakeup";
      };
    };
  };

  environment.systemPackages = lib.optionals config.services.xserver.enable [ pkgs.xprintidle ];
}
