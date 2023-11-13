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
        "backup"
        "esphome"
        "forked_daapd"
        "freebox"
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

      # TODO: need a PR to be merged
      # customComponents = with pkgs.home-assistant-custom-components; [
      #   prometheus-sensor
      # ];

      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = {};

        "automation manual" = [
          {
            alias = "Living Room · Turn on Lights";
            trigger = {
              platform = "device";
              domain = "zha";
              device_id = "0e5fb6683244a298f90a8e332b883f7c";
              type = "remote_button_short_press";
              subtype = "turn_on";
            };
            action = {
              service = "light.turn_on";
              target.entity_id = [
                "light.living_room_ceiling_1_light"
                "light.living_room_ceiling_2_light"
              ];
            };
          }
        ];
        "automation ui" = "!include automations.yaml";

      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 80 443 8123 8883 ];
    };
  };
}
