{ pkgs, config, lib, ... }:

{
  environment = {
    systemPackages = [
      pkgs.nnn
    ];
    etc."nnn/std".source = "${pkgs.nnn}/share/plugins";
    etc."nnn/cd.sh".source = ./cd.sh;
  };

  programs.bash.interactiveShellInit = ''
    export NNN_OPTS="daAR"
    export NNN_PLUG="p:/etc/nnn/std/preview-tui;d:/etc/nnn/std/diffs;c:/etc/nnn/cd.sh"
  '';

  home-config = lib.optionalAttrs config.programs.starship.enable {
    nnn = ./home-config;
  };
}
