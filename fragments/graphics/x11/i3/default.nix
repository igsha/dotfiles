{ pkgs, ... }:

let
  popup-wcalc = pkgs.writeScriptBin "popup-wcalc" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup -t wcalc -e wcalc
  '';
  popup-translate = pkgs.writeScriptBin "popup-translate" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup -t translate -e trans -I
  '';
  message-recorder = pkgs.writeScriptBin "message-recorder" (builtins.readFile ./message-recorder);

in {
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      ponymix
      i3blocks-gaps
      numlockx
      xkb-switch-i3
      popup-wcalc
      popup-translate
      message-recorder
      flameshot
      dunst
    ];
    configFile = ./config;
  };

  home-config.i3 = {
    packages = [ "dunst" "i3blocks" ];
    dir = builtins.toString ./home-config;
  };
}
