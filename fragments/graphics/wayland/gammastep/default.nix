{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    package = pkgs.gammastep;
    executable = "/bin/gammastep";
  };
}
