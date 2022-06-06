{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ../home-manager.nix
  ];

  users.users.domi = {
    # required for build-vm
    initialPassword = "changeme";

    isNormalUser = true;
    description = "Domi";
    extraGroups = ["networkmanager" "wheel"];
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
            #programs
            "${modifier}+Shift+d" = "exec discord";
            "${modifier}+Shift+t" = "exec telegram-desktop";
            "${modifier}+Shift+f" = "exec firefox";
            "${modifier}+t" = "exec pcmanfm";

            #lock
            "${modifier}+Shift+z" = "exec i3lock -c 000000";

            #suspend
            "${modifier}+Shift+u" = "exec i3lock -c 000000 && systemctl suspend";

            # Rofi
            "${modifier}+d" = ''
              exec --no-startup-id "rofi -combi-modi window,drun -show combi -modi combi"'';

            # Screenshots
            "${modifier}+Shift+s" = ''
              exec shotgun $(hacksaw -f "-i %i -g %g") - | xclip -t image/png -selection clipboard'';
          };

        terminal = "alacritty";

        window.border = 0;

        startup = with pkgs; [
          {
            command = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
            notification = false;
          }
        ];
      };
    };

    programs = {
      bash = {
        enable = true;
      };

      obs-studio.enable = true;

      i3status.enable = true;
      rofi.enable = true;

      alacritty = {
        enable = true;
      };

      mpv.enable = true;

      htop.enable = true;

      exa = {
        enable = true;
        enableAliases = true;
      };

      firefox = {
        enable = true;
        profiles = {
          domi = {
            isDefault = true;
          };
        };
      };
    };
    gtk = {
      enable = true;

      font.name = "Fira Sans";

      theme = {
        name = "Pop-dark";
        package = pkgs.pop-gtk-theme;
      };

      iconTheme = {
        name = "Pop";
        package = pkgs.pop-icon-theme;
      };

      cursorTheme = {
        name = "capitaine-cursors-white";
        package = pkgs.capitaine-cursors;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    blender
    ffmpeg

    # nix file formatter
    # using with its vscode extension
    alejandra
  ];
}
