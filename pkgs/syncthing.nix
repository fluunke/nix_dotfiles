{
  pkgs,
  config,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "domi";

    configDir = "/home/domi/.config/syncthing";

    folders = {
      "/home/domi/Projects" = {
        id = "projects";
      };
    };
  };
}
