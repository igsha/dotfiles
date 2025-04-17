{ ... }:

{
  services.geoclue2 = {
    enable = true;
    enableNmea = false;
    appConfig = {
      qutebrowser = {
        isSystem = false;
        isAllowed = true;
        desktopID = "org.qutebrowser.qutebrowser";
      };
    };
  };

  location.provider = "geoclue2";
}
