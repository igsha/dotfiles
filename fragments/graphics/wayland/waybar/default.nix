_:

{
  programs.waybar.enable = true;

  home-config.waybar = {
    packages = [ "waybar" ];
    dir = builtins.toString ./home-config;
  };
}
