{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.steam;
in
{
  options.${namespace}.apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable support for Steam.";
    uiScaling = mkBoolOpt false "Whether or not to enable UI scaling for Steam.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      gamescopeSession = {
        enable = true;
        env = {
          WLR_RENDERER = "vulkan";
          DXVK_HDR = "1";
          ENABLE_GAMESCOPE_WSI = "1";
          WINE_FULLSCREEN_FSR = "1";
          # Games allegedly prefer X11
          SDL_VIDEODRIVER = "x11";
        };
        args = [
          "--xwayland-count 2"
          "--expose-wayland"

          "-e" # Enable steam integration
          "--steam"

          "--adaptive-sync"
          "--hdr-enabled"
          "--hdr-itm-enable"

          # External monitor
          # "--prefer-output HDMI-A-1"
          # "--output-width 2560"
          # "--output-height 1440"
          # "-r 75"

          # Laptop display
          # "--prefer-output eDP-1"
          # "--output-width 2560"
          # "--output-height 1600"
          # "-r 120"

          # "--prefer-vk-device" # lspci -nn | grep VGA
          # "1002:73ef" # Dedicated
          # 1002:1681 # Integrated
        ];
      };
    };

    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      steamtinkerlaunch
      xdotool
      xorg.xwininfo
      unixtools.xxd
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      STEAM_FORCE_DESKTOPUI_SCALING = lib.optional (cfg.uiScaling) "2";
    };
  };
}
