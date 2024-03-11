{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.davmail
  ];

  home-config.davmail = {
    packages = [ "davmail" ];
    dir = builtins.toString ./home-config;
  };
}
