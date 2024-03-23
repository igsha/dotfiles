_:

{
  home-config.mail = {
    packages = [ "mail" ];
    dir = builtins.toString ./home-config;
  };
}
