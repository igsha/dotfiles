{ pkgs, ... }:

{
  systemd.user.services.tgwsproxy = {
    enable = true;
    description = "Local proxy for tg";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tgwsproxy}/bin/tgwsproxy --port 11443 --secret d204371a558f1b974849b015ef67e864 --no-update-check";
      Restart = "on-failure";
    };
  };
}
