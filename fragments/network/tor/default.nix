{ lib, ... }:

let
  torList = builtins.fetchurl https://torscan-ru.ntc.party/relays.txt;
  servers = builtins.filter (x: x != "") (lib.strings.splitString "\n" (builtins.readFile torList));

in {
  services.tor = {
    enable = true;
    client = {
      enable = true;
      dns.enable = false;
    };
    settings = {
      FascistFirewall = true;
    } // builtins.listToAttrs (map (x: lib.nameValuePair "Bridge" x) servers);
  };
}
