{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    simpleproxy
    pacproxy
    socks-to-http-proxy
  ];

  programs.proxychains = {
    enable = true;
    proxies = {
      myproxy = {
        enable = true;
        type = "http";
        host = "127.0.0.1";
        port = 11080;
      };
    };
  };

  home-config.proxy = ./home-config;
}
