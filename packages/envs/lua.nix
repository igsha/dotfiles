pkgs:

pkgs.mkShell {
  name = "luaenv";
  buildInputs = with pkgs; [ love libGL lua ];
  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
  '';
}
