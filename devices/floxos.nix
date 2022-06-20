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
    ../pkgs/docker.nix
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

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };

    initrd = {
      kernelModules = ["amdgpu"];
    };
  };

  networking.firewall.enable = false;

  hardware = {
    opengl.driSupport = true;
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;

    opengl.extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  networking = {
    hostName = "floxos";
    networkmanager.enable = true;

    #firewall.allowedTCPPorts = [];
    #firewall.allowedUDPPorts = [];
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
