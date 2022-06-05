{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./kernel.nix
    ./pkgs.nix
    ./fonts.nix
  ];

  boot = {
    supportedFilesystems = ["ntfs"];
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    initrd = {
      luks.devices."luks-c252bafc-25ae-43ad-8fad-0d8726eddfae".device = "/dev/disk/by-uuid/c252bafc-25ae-43ad-8fad-0d8726eddfae";
      luks.devices."luks-c252bafc-25ae-43ad-8fad-0d8726eddfae".keyFile = "/crypto_keyfile.bin";
      kernelModules = ["amdgpu"];
    };
  };

  networking = {
    hostName = "floxos";

    networkmanager.enable = true;

    firewall.allowedTCPPorts = [];
    firewall.allowedUDPPorts = [];
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  services.xserver = {
    enable = true;

    layout = "de";
    xkbVariant = "nodeadkeys";

    videoDrivers = ["amdgpu"];

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    displayManager = {
      sddm.enable = true;

      # monitor config
      setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr \
        --output DisplayPort-2 --mode 2560x1440 --rate 143.91 --primary \
        --output DisplayPort-1 --mode 1920x1080 --right-of DisplayPort-2 \
        || true
      '';
    };
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.udisks2.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    # Jack support
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.domi = {
    # password for build-vm
    initialPassword = "vm";

    isNormalUser = true;
    description = "Domi";
    extraGroups = ["networkmanager" "wheel"];
  };

  hardware.opengl.driSupport32Bit = true;

  system.stateVersion = "22.05";
}
