{ pkgs, config, lib, ... }:

{
  environment = {
    systemPackages = [
      pkgs.nnn
    ];
    etc.nnn.source = "${pkgs.nnn}/share/plugins";
  };

  programs.bash.interactiveShellInit = ''
    export NNN_OPTS="daAR"
    export NNN_PLUG="p:/etc/nnn/preview-tui;d:/etc/nnn/diffs"
  '';

  home-config = lib.optionalAttrs config.programs.starship.enable {
    nnn = {
      packages = [ "nnn" ];
      dir = builtins.toString ./home-config;
    };
  };
}
