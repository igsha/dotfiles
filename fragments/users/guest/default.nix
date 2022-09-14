_:

{
  users = {
    users.guest = {
      isSystemUser = true;
      group = "guest";
      description = "Guest session for ssh";
      initialPassword = "guest";
      createHome = false;
    };
    groups = {
      guest = {};
    };
  };
}
