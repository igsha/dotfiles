{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.davmail
  ];

  home-config.davmail = ./home-config;
}
