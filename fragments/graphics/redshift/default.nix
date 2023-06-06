{ pkgs, config, lib, ... }:

{
  services.redshift = {
    enable = true;
  } // lib.optionalAttrs (!config.services.xserver.enable) {
    package = pkgs.gammastep;
    executable = "/bin/gammastep";
  };
}
