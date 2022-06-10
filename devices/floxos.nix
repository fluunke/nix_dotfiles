{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../kernels/xanmod.nix
    ../pkgs/chatting.nix
    ../pkgs/code.nix
    ../pkgs/desktop.nix
    ../pkgs/printer.nix
    ../pkgs/random-background.nix
    ../pkgs/sound.nix
    ../pkgs/steam.nix
    ../pkgs/syncthing.nix
    ../users/domi.nix
    ../fonts.nix
  ];
  boot = {
    supportedFilesystems = ["ntfs"];

    # fix keychron F keys
    extraModprobeConfig = "options hid_apple fnmode=0\n";

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

  hardware.opengl.driSupport32Bit = true;

  networking = {
    hostName = "floxos";
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [8080 3030];
    firewall.allowedUDPPorts = [8080 3030];
  };

  services.udisks2.enable = true;

  console.keyMap = "de-latin1-nodeadkeys";

  time.timeZone = "Europe/Berlin";

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
    layout = "de";
    xkbVariant = "nodeadkeys";
    videoDrivers = ["amdgpu"];

    # monitor config
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr \
      --output DisplayPort-2 --mode 2560x1440 --rate 143.91 --primary \
      --output DisplayPort-1 --mode 1920x1080 --right-of DisplayPort-2 \
      || true
    '';
  };
}
