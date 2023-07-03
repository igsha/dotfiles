{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flameshot
  ];

  home-config.screenshot = {
    packages = [ "flameshot" ];
    dir = builtins.toString ./home-config;
  };
}
