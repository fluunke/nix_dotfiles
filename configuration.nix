{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./devices/floxos.nix
    ./utils.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.dconf.enable = true;

  boot.cleanTmpDir = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "22.05";
}
