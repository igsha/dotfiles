{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${config.custom-args.greetd.cmd}";
      };
    };
    vt = 2;
  };
}
