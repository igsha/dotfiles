{ pkgs, ... }:

{
  systemd.user.services.google-drive = {
    enable = true;
    description = "Mount google drive";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f \${HOME}/Google/Drive";
      Type = "simple";
    };
  };
}
