{ pkgs, config, lib, ... }:

let
  timeout = 1200;
  check-idle = pkgs.writeShellApplication {
    name = "check-idle.sh";
    runtimeInputs = with pkgs; [ systemd jq coreutils xprintidle ];
    text = ''
      DELTA=${builtins.toString timeout}
      for __s in $(loginctl list-sessions --output json | jq -r '.[] | .session'); do
        if [[ $(loginctl show-session "$__s" --value -p Active) != "yes" ]]; then
          continue
        fi
        case $(loginctl show-session "$__s" --value -p Type) in
          "tty")
            __tty=$(loginctl show-session "$__s" --value -p TTY)
            __d=$(( $(date +%s) - $(stat -c %X "/dev/$__tty") ))
            if [[ $__d -lt $DELTA ]]; then exit 0; fi;;
          "x11")
            __disp=$(loginctl show-session "$__s" --value -p Display)
            __xauth=/home/$(loginctl show-session "$__s" --value -p Name)/.Xauthority
            __d=$(DISPLAY="$__disp" XAUTHORITY="$__xauth" xprintidle)
            if [[ $__d -lt $DELTA ]]; then exit 0; fi;;
          "wayland") echo No idle checker for wayland >&2;;
        esac
      done
      exit 1
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
        Load.threshold = 0.5;
        LogindSessionsIdle.enabled = true;
        /*ExternalCommand = {
          command = "${check-idle}/bin/check-idle.sh";
        };*/
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
