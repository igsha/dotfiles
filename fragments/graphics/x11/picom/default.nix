_:

{
  services.picom = {
    enable = true;
    vSync = true;
    backend = "xrender";
    settings = {
      unredir-if-possible = false;
    };
  };
}
