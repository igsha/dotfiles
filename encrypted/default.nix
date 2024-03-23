_:

{
  home-config.mail = {
    packages = [ "offlineimap" ];
    dir = builtins.toString ./home-config;
  };
}
