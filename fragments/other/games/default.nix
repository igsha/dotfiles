{ pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    shattered-pixel-dungeon
    protontricks
    gamescope
  ];
}
