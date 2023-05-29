_:

{
  services = {
    autosuspend = {
      enable = true;
      settings = {
        interval = 300;
        idle_time = 1200;
      };
      checks = {
        Load.threshold = 3.0;
        LogindSessionsIdle.enabled = true;
      };
      wakeups = {
        File.path = "/var/run/autosuspend/wakeup";
      };
    };
  };
}
