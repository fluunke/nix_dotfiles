{pkgs, ...}: {
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    displayManager.sddm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lxappearance

    # screenshots
    hacksaw
    shotgun
    xclip

    # media
    pcmanfm
    evince
    viewnior
  ];
}
