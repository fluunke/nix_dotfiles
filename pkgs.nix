{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home-manager.nix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # email/calendar client
  programs.evolution = {
    enable = true;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.domi = {pkgs, ...}: {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";

        keybindings = let
          modifier =
            config.home-manager.users.domi.xsession.windowManager.i3.config.modifier;
        in
          lib.mkOptionDefault {
            "${modifier}+Shift+d" = "exec discord";
            "${modifier}+Shift+f" = "exec firefox";

            # Rofi
            "${modifier}+d" = ''
              exec --no-startup-id "rofi -combi-modi window,drun -show combi -modi combi"'';

            # Screenshots
            "${modifier}+Shift+s" = ''
              exec shotgun $(hacksaw -f "-i %i -g %g") - | xclip -t image/png -selection clipboard'';
          };

        terminal = "alacritty";

        window.border = 0;

        startup = [];
      };
    };

    services.random-background = {
      enable = true;
      imageDirectory = "%h/.backgrounds";
      interval = "1m";
    };

    programs = {
      bash = {
        enable = true;
      };
      i3status.enable = true;
      rofi.enable = true;

      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          matklad.rust-analyzer
          yzhang.markdown-all-in-one
        ];
      };

      alacritty = {
        enable = true;
      };

      git = {
        enable = true;
        delta.enable = true;
        userEmail = "flrk@tuta.io";
        userName = "fluunke";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };

      gitui.enable = true;

      mpv.enable = true;

      firefox = {
        enable = true;
        profiles = {
          domi = {
            isDefault = true;
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # tools
    wget
    lxappearance
    killall
    unrar
    unzip
    zip
    yt-dlp-light
    p7zip
    fd
    kalker
    pcmanfm

    # screenshots
    hacksaw
    shotgun
    xclip

    # chats
    tdesktop
    discord

    # programming
    rustc
    cargo
    gcc

    # media
    pavucontrol
    evince
    spotify
    viewnior
    blender
    ffmpeg
    gnome.gnome-maps

    # nix file formatter
    # using with its vscode extension
    alejandra

    # polkit stuff
    polkit
    mate.mate-polkit
  ];
}
