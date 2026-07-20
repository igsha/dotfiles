{ pkgs, lib, ... }:

{
  networking.firewall.extraCommands = ''
    ip46tables -t mangle -I POSTROUTING -p tcp -m multiport --dports 443,80 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
  '';

  systemd.packages = [
    (pkgs.runCommand "machines" {
      preferLocalBuild = true;
      allowSubstitutes = false;
    } ''
      mkdir -p $out/etc/systemd/system/
      ln -s ${pkgs.zapret2}/lib/systemd/system/nfqws2@.service $out/etc/systemd/system/nfqws2@pgts.service
    '')
  ];

  environment = let
    default-options = [
      "--qnum=200"
      ''--lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-lib.lua"''
      ''--lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-antidpi.lua"''
    ];
    fast-check-nfqws2 = pkgs.writeShellApplication {
      name = "fast-check-nfqws2.sh";
      text = ''
        nfqws2 --debug ${builtins.concatStringsSep " " default-options} "$@"
      '';
    };
    fast-blockcheck2 = pkgs.writeShellApplication {
      name = "fast-blockcheck2.sh";
      text = ''
        DOMAINS="$1" IPVS=4 ENABLE_HTTP3=0 ENABLE_HTTP=0 ENABLE_HTTPS_TLS12=0 ENABLE_HTTPS_TLS13=1 REPEATS=1 SCANLEVEL=quick TEST=standard SKIP_DNSCHECK=1 CURL_HTTPS_GET=1 blockcheck2
      '';
    };
    config-options = pkgs.runCommand "decodeb64" {
      buildInputs = [ pkgs.coreutils ];
    } ''
      base64 -d ${./config.b64} >> $out
    '';

  in {
    systemPackages = [
      pkgs.zapret2
      fast-check-nfqws2
      fast-blockcheck2
    ];
    etc."zapret2/pgts.conf".text = (builtins.concatStringsSep "\n" default-options) + "\n\n" + (builtins.readFile config-options);
  };
}
