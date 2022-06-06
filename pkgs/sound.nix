{pkgs, ...}: {
  sound.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    # Jack support (for DAWs)
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    spotify
  ];
}
