_:

{
  imports = [ ../../fragments/network ];

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  services = {
    openvpn.servers = {
      elvees = {
        config = "config /home/igor/.vpn/elvees2fa.conf";
        autoStart = false;
        updateResolvConf = true;
      };
      miet = {
        config = "config /home/igor/.vpn/miet.conf";
        autoStart = false;
        updateResolvConf = false;
      };
    };
  };
}
