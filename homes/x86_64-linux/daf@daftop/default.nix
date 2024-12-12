{
  lib,
  config,
  namespace,
  pkgs,
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
        themeSwitcher = true;
        desktop.digitalClock.position.horizontal = 1200;
      };
    };

    programs = {
      graphical = {
        browsers = {
          firefox = {
            enable = true;
            package = pkgs.firefox-beta;
            gpuAcceleration = true;
            hardwareDecoding = true;
            settings = {
              # "dom.ipc.processCount.webIsolated" = 9;
              # "dom.maxHardwareConcurrency" = 16;
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

    system = {
      xdg = enabled;
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
        drawing = enabled;
      };

      music = enabled;
      office = enabled;
      social = enabled;
      video = enabled;
    };
  };
}
