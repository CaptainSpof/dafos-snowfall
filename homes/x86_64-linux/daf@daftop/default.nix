{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib.${namespace}) enabled;
in
{
  dafos = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    desktop = {
      plasma = {
        touchScreen = true;
        config = {
          virtualDesktopsNames = [
            "Mail"
            "Video"
            "Other"
            "Stuff"
            "Yes"
          ];
        };
        panels = {
          topPanel = {
            maxLength = 1600;
            minLength = 1400;
          };
          topPanelBis = {
            maxLength = 2000;
            minLength = 1800;
          };
          leftPanel.launchers =
            [
            "applications:org.kde.dolphin.desktop"
            "applications:firefox.desktop"
            "applications:kitty.desktop"
            "applications:emacsclient.desktop"
          ];
        };
      };
    };

    programs = {
      graphical = {
        browsers = {
          firefox = {
            enable = true;
            gpuAcceleration = true;
            hardwareDecoding = true;
            settings = {
              # "dom.ipc.processCount.webIsolated" = 9;
              # "dom.maxHardwareConcurrency" = 16;
              # "media.av1.enabled" = false;
              # "media.ffvpx.enabled" = false;
              "media.hardware-video-decoding.force-enabled" = true;
              "media.hardwaremediakeys.enabled" = true;
            };
          };
        };
        instant-messengers = {
          teamspeak.enable = lib.mkForce false;
        };
      };

      terminal = {
        tools = {
          ssh = enabled;
        };
      };
    };

    suites = {
      common = enabled;
      desktop = enabled;

      development = {
        enable = true;
        aws.enable = true;
      };

      games = enabled;

      graphics = {
        enable = true;
        drawing.enable = true;
      };

      music = enabled;
      office = enabled;
      social = enabled;
      video = enabled;
    };
  };
}
