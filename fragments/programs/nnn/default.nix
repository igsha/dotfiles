{ pkgs, ... }:

{
  environment = {
    systemPackages = [
      pkgs.nnn
    ];
    etc.nnn.source = "${pkgs.nnn}/share/plugins";
  };

  programs.bash.interactiveShellInit = ''
    export NNN_OPTS="deca"
    export NNN_PLUG="p:/etc/nnn/preview-tui;d:/etc/nnn/diffs"
  '';
}
