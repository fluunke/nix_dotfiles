{
  config,
  pkgs,
  ...
}: {
  config.virtualisation.docker.enable = true;
  config.users.users.domi.extraGroups = ["docker"];
  config.environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
