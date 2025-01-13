{ pkgs, ... }:

{
  programs = {
    evolution = {
      enable = true;
      plugins = [ pkgs.evolution-ews ];
    };
    thunderbird = {
      enable = true;
      package = pkgs.thunderbird-latest;
    };
  };

  environment.systemPackages = [
    pkgs.birdtray
  ];
}
