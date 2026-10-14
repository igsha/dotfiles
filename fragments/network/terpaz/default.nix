{ pkgs, lib, config, ... }:

let
  preamble = [
    "--qnum=200"
    ''--lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-lib.lua"''
    ''--lua-init=@"${pkgs.zapret2}/share/zapret2/lua/zapret-antidpi.lua"''
  ];
  preamble-file = pkgs.writeText "terpaz-start.conf" (lib.concatStringsSep "\n" (preamble
    ++ [ "# == config start ==" "" ]));
  hosts = let
    m = { a = "r"; c = "a"; i = "e"; p = "y"; q = "t"; r = "c"; s = "j"; t = "o"; b = "i"; z = "w"; o = "v"; d = "."; };
    servname1 = lib.strings.stringAsChars (x: m.${x}) "stpaicrqtadrr";
    servname2 = lib.strings.stringAsChars (x: m.${x}) "bzcacdqo";
  in {
    "31.13.66.63" = [ "scontent-hel3-1.cdninstagram.com" "scontent.cdninstagram.com" "static.cdninstagram.com" ];
    "31.13.67.20" = [ "scontent-hel3-1.xx.fbcdn.net" ];
    "57.144.154.34" = [ "instagram.com" "www.instagram.com" ];
    "57.144.62.192" = [ "graph.instagram.com" ];
    "57.128.232.51" = map (x: "${x}.${servname1}") [ "img1" "img11" "img2" ];
    "89.222.125.215" = [ "pix-cdn77.phncdn.com" ];
    "8.47.69.0" = [ servname2 ] ++ map (x: "${x}.${servname2}") [ "www" "apiq" ];
  };
  hosts-content = (lib.concatMapAttrsStringSep "\n" (name: value: [name] ++ value |> lib.concatStringsSep " ") hosts) + "\n";
  hosts-file = pkgs.writeText "hosts.txt" hosts-content;
  iptable-args = ''
    -t mangle -I POSTROUTING -p tcp \
    -m multiport --dports 443,80 \
    -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 \
    -m mark ! --mark 0x40000000/0x40000000 \
    -j NFQUEUE --queue-num 200 --queue-bypass
  '';
  fast-commands = let
    init = ''
      cat ${hosts-file} >> /etc/hosts
      iptables ${iptable-args}
    '';
    entrypoint1 = pkgs.writeShellApplication {
      name = "entrypoint";
      runtimeInputs = [ pkgs.zapret2 pkgs.iptables ];
      runtimeEnv = {
        IPVS = 4;
        ENABLE_HTTP3 = 0;
        ENABLE_HTTP = 0;
        ENABLE_HTTPS_TLS12 = 0;
        ENABLE_HTTPS_TLS13 = 1;
        REPEATS = 1;
        SCANLEVEL = "quick";
        TEST = "standard";
        SKIP_DNSCHECK = 1;
        CURL_HTTPS_GET = 1;
      };
      text = ''
        ${init}
        DOMAINS="$1" exec blockcheck2
      '';
    };
    entrypoint2 = pkgs.writeShellApplication {
      name = "entrypoint";
      runtimeInputs = [ pkgs.zapret2 pkgs.iptables ];
      text = ''
        ${init}
        nfqws2 --debug ${builtins.concatStringsSep " " preamble} "$@"
      '';
    };
  in pkgs.writeShellApplication {
    name = "terpaz-fast-check.sh";
    text = ''
      NAME="$1"
      shift
      if [[ "$NAME" == search ]]; then
        ENTRYPOINT="${entrypoint1}/bin/entrypoint"
      else
        ENTRYPOINT="${entrypoint2}/bin/entrypoint"
      fi
      ${pkgs.docker}/bin/docker run --rm --name "terpaz-fast-$NAME" \
        --cap-add=NET_ADMIN \
        --cap-add=SETPCAP \
        -v /nix/store:/nix/store:ro \
        --entrypoint "$ENTRYPOINT" \
        alpine:3.24.2 "$@"
    '';
  };
  generate-config = pkgs.writeShellApplication {
    name = "generate";
    text = ''
      ${pkgs.coreutils}/bin/cp "${preamble-file}" "$1"
      ${pkgs.coreutils}/bin/base64 -d "$2" >> "$1"
    '';
  };

in {
  virtualisation.docker.enable = true;

  networking = {
    firewall.extraCommands = ''
      ip46tables ${iptable-args}
    '';
    inherit hosts;
  };

  environment.systemPackages = [
    fast-commands
  ];

  systemd.services.terpaz = {
    enable  = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      RuntimeDirectory = "terpaz";
      ExecStartPre = [
        "+${pkgs.coreutils}/bin/mkdir -p /run/terpaz"
        "+${generate-config}/bin/generate /run/terpaz/config.conf /home/${config.custom-args.user}/.config/terpaz/config.b64"
        "+${pkgs.coreutils}/bin/chmod -R 755 /run/terpaz"
      ];
      ExecStart = "${pkgs.zapret2}/bin/nfqws2 @/run/terpaz/config.conf";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW";
      NoNewPrivileges = true;
      ProtectSystem = "full";
      DynamicUser = true;
      SystemCallFilter = "@system-service";
      SystemCallArchitectures = "native";
      StateDirectory = "terpaz";
      ReadWritePaths = [ "/run/terpaz" ];
    };
  };

  home-config.terpaz = ./home-config;
}
