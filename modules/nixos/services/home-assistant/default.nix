{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.services.home-assistant;
  vars = config.dafos.vars;
in
{
  imports = [ ../../../vars.nix ];
  options.dafos.services.home-assistant = with types; {
    enable = mkBoolOpt false "Whether or not to enable home-assistant.";
    serialPort = mkOpt str "/dev/ttyACM0" "The serial port to use.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      ffmpeg_5
    ];

    services.home-assistant = {
      enable = true;
      extraComponents = [
        "apple_tv"
        "backup"
        "esphome"
        "forked_daapd"
        "freebox"
        "google_translate"
        "ipp"
        "met"
        "netatmo"
        "radio_browser"
        "samsungtv"
        "wled"
        "yeelight"
        "zha"
      ];

      extraPackages = ps: with ps; [
        pychromecast
      ];

      customComponents = with pkgs.home-assistant-custom-components; [
        prometheus-sensor
        pkgs.dafos.adaptive-lighting
      ];

      customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
        mini-graph-card
        mini-media-player
        pkgs.dafos.lovelace-mushroom
      ];

      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = {
          name = "DafHome";
        };

        "automation manual" = [ ];
        "automation ui" = "!include automations.yaml";
        "scene ui" = "!include scenes.yaml";
        "script ui" = "!include scripts.yaml";
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 80 443 8123 ];
    };
  };
}
