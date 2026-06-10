{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    input.keyboard = {
      numlockOnStartup = "on";
    };

    hotkeys.commands = {
      launch-konsole = {
        name = "Launch Konsole";
        key = "Super+Enter";
        command = "konsole";
      };
    };

    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
      menu = {
        family = "Noto Sans";
        pointSize = 10;
      };
      small = {
        family = "Noto Sans";
        pointSize = 8;
      };
      toolbar = {
        family = "Noto Sans";
        pointSize = 10;
      };
      windowTitle = {
        family = "Noto Sans";
        pointSize = 10;
      };
    };

    kwin = {
      effects = {
        blur = {
          enable = true;
          noiseStrength = 0;
          strength = 5;
        };
        translucency.enable = true;
      };
      virtualDesktops = {
        number = 2;
        rows = 1;
      };
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    kscreenlocker = {
      appearance = {
        showMediaControls = false;
      };
    };

    panels = [
      {
        location = "bottom";
        height = 48;
        widgets = [
          "org.kde.plasma.kickoff"
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:org.kde.konsole.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      ksplashrc.KSplash = {
        Engine = "none";
        Theme = "None";
      };
    };
  };
}
