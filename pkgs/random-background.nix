{...}: {
  home-manager.users.domi.services.random-background = {
    enable = true;
    imageDirectory = "%h/.backgrounds";
    interval = "1h";
  };
}
