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
    extraGroups = ["networkmanager" "wheel" "scanner"];
  };

  # email/calendar client
  programs.evolution = {
    enable = true;
  };

  programs.file-roller.enable = true;

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
            settings = {
              "app.normandy.enabled" = false;
              "app.shield.optoutstudies.enabled" = false;
              "app.update.auto" = false;
              "beacon.enabled" = false;
              "browser.aboutConfig.showWarning" = false;
              "browser.cache.offline.enable" = false;
              "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
              "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
              "browser.crashReports.unsubmittedCheck.enabled" = false;
              "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
              "browser.newtabpage.enhanced" = false;
              "browser.safebrowsing.blockedURIs.enabled" = false;
              "browser.safebrowsing.downloads.enabled" = false;
              "browser.safebrowsing.downloads.remote.enabled" = false;
              "browser.safebrowsing.enabled" = false;
              "browser.safebrowsing.malware.enabled" = false;
              "browser.safebrowsing.phishing.enabled" = false;
              "browser.send_pings" = false;
              "browser.shell.checkDefaultBrowser" = false;
              "browser.tabs.crashReporting.sendReport" = false;
              "browser.urlbar.groupLabels.enabled" = false;
              "browser.urlbar.quicksuggest.enabled" = false;
              "browser.urlbar.trimURLs" = false;
              "datareporting.healthreport.service.enabled" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "datareporting.policy.dataSubmissionEnabled" = false;
              "dom.battery.enabled" = false;
              "dom.event.clipboardevents.enabled" = false;
              "experiments.activeExperiment" = false;
              "experiments.enabled" = false;
              "experiments.supported" = false;
              "extensions.getAddons.cache.enabled" = false;
              "extensions.getAddons.showPane" = false;
              "extensions.greasemonkey.stats.optedin" = false;
              "extensions.pocket.enabled" = false;
              "extensions.shield-recipe-client.enabled" = false;
              "media.navigator.enabled" = false;
              "media.video_stats.enabled" = false;
              "network.allow-experiments" = false;
              "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
              "toolkit.telemetry.archive.enabled" = false;
              "toolkit.telemetry.bhrPing.enabled" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.firstShutdownPing.enabled" = false;
              "toolkit.telemetry.hybridContent.enabled" = false;
              "toolkit.telemetry.newProfilePing.enabled" = false;
              "toolkit.telemetry.reportingpolicy.firstRun" = false;
              "toolkit.telemetry.shutdownPingSender.enabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.unifiedIsOptIn" = false;
              "toolkit.telemetry.updatePing.enabled" = false;
              "webgl.vendor-string-override" = " ";
              "webgl.renderer-string-override" = " ";
              "app.normandy.api_url" = "";
              "breakpad.reportURL" = "";
              "browser.disableResetPrompt" = true;
              "browser.newtabpage.introShown" = true;
              "browser.safebrowsing.appRepURL" = "";
              "browser.safebrowsing.downloads.remote.url" = "";
              "browser.selfsupport.url" = "";
              "browser.sessionstore.privacy_level" = 2;
              "browser.startup.homepage_override.mstone" = "ignore";
              "experiments.manifest.uri" = "";
              "extensions.CanvasBlocker@kkapsner.de.whiteList" = "";
              "extensions.ClearURLs@kevinr.whiteList" = "";
              "extensions.Decentraleyes@ThomasRientjes.whiteList" = "";
              "extensions.greasemonkey.stats.url" = "";
              "extensions.shield-recipe-client.api_url" = "";
              "extensions.webservice.discoverURL" = "";
              "media.autoplay.default" = 0;
              "media.autoplay.enabled" = true;
              "network.cookie.cookieBehavior" = 1;
              "network.http.referer.spoofSource" = true;
              "network.trr.mode" = 5;
              "privacy.donottrackheader.enabled" = true;
              "privacy.donottrackheader.value" = 1;
              "privacy.trackingprotection.cryptomining.enabled" = true;
              "privacy.trackingprotection.enabled" = true;
              "privacy.trackingprotection.fingerprinting.enabled" = true;
              "privacy.trackingprotection.pbmode.enabled" = true;
              "privacy.usercontext.about_newtab_segregation.enabled" = true;
              "security.ssl.disable_session_identifiers" = true;
              "toolkit.telemetry.cachedClientID" = "";
              "toolkit.telemetry.prompted" = 2;
              "toolkit.telemetry.rejected" = true;
              "toolkit.telemetry.server" = "";
            };
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
    imagemagick

    # nix file formatter
    # using with its vscode extension
    alejandra
  ];
}
