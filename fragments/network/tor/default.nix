{ lib, pkgs, ... }:

{
  services.tor = {
    enable = true;
    client = {
      enable = true;
      dns.enable = false;
    };
    settings = {
      Bridge = lib.strings.concatStringsSep " " [
        "snowflake 192.0.2.4:80 8838024498816A039FCBBAB14E6F40A0843051FA"
        "fingerprint=8838024498816A039FCBBAB14E6F40A0843051FA"
        "url=https://snowflake-broker.torproject.net.global.prod.fastly.net/"
        "front=cdn.sstatic.net "
        ("ice=" + lib.strings.concatStringsSep "," [
          "stun:stun.l.google.com:19302"
          "stun:stun.antisip.com:3478"
          "stun:stun.bluesip.net:3478"
          "stun:stun.dus.net:3478"
          "stun:stun.epygi.com:3478"
          "stun:stun.sonetel.net:3478"
          "stun:stun.uls.co.za:3478"
          "stun:stun.voipgate.com:3478"
          "stun:stun.voys.nl:3478"
        ])
        "utls-imitate=hellorandomizedalpn"
      ];
      ClientTransportPlugin = "snowflake exec ${pkgs.snowflake}/bin/client";
      UseBridges = 1;
      ReachableAddresses = [ "*:80" "*:443" ];
    };
  };
}
