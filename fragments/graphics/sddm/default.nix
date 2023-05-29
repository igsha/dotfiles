_:

{
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
    };
    sessionCommands = ''
      systemctl --user import-environment \
        DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY PATH NIX_PATH \
        XDG_{DATA_DIRS,RUNTIME_DIR,SESSION_{ID,TYPE},CONFIG_DIRS}
      kbdd
    '';
  };
}
