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

    dafos.user.extraGroups = [ "hass" ];

    environment.systemPackages = with pkgs; [
      ffmpeg_5
    ];

    services.home-assistant = {
      enable = true;
      extraComponents = [
        "apple_tv"
        "backup"
        "cast"
        "esphome"
        "forked_daapd"
        "freebox"
        "google_translate"
        "ipp"
        "met"
        "mobile_app"
        "netatmo"
	      "sonarr"
	      "radarr"
        "radio_browser"
        "roborock"
        "samsungtv"
        "telegram"
        "tailscale"
        "wled"
        "yeelight"
        "zeroconf"
        "zha"
      ];

      extraPackages = ps: with ps; [
        pychromecast
      ];

      customComponents = with pkgs.home-assistant-custom-components; [
        adaptive_lighting
      ];

      customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
        mini-graph-card
        mini-media-player
        mushroom
        pkgs.dafos.lovelace-layout-card
        pkgs.dafos.lovelace-fold-entity-row
        pkgs.dafos.lovelace-auto-entities
        pkgs.dafos.button-card
      ];

      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = {
          name = "DafHome";
        };
        lovelace.mode = "yaml";
        lovelace.resources = [
          {
            url = "/local/nixos-lovelace-modules/mushroom.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/layout-card.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/button-card.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/fold-entity-row.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/auto-entities.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/mini-graph-card-bundle.js";
            type = "module";
          }
          {
            url = "/local/nixos-lovelace-modules/mini-media-player-bundle.js";
            type = "module";
          }
        ];

        "automation manual" = [ ];
        "automation ui" = "!include automations.yaml";
        "scene ui" = "!include scenes.yaml";
        "script ui" = "!include scripts.yaml";

        sensor = {
          platform = "time_date";
          display_options = [
            "time"
            "date"
            "date_time"
            "date_time_utc"
            "date_time_iso"
            "time_date"
            "time_utc"
            "beat"
          ];
        };
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 80 443 8123 ];
    };
  };
}
