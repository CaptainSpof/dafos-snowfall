{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.services.home-assistant;
in
{
  options.${namespace}.services.home-assistant = {
    enable = mkBoolOpt false "Whether or not to enable home-assistant.";
    serialPort =
      mkOpt types.str
        "/dev/serial/by-id/usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20230803143100-if00"
        "The serial port to use with ZHA.";
    serialPortZigbee2Mqtt =
      mkOpt types.str
        "/dev/serial/by-id/usb-dresden_elektronik_ingenieurtechnik_GmbH_ConBee_II_DE2289092-if00"
        "The serial port to use with Zigbee2mqtt.";
  };

  config = mkIf cfg.enable {

    dafos.user.extraGroups = [ "hass" ];

    environment.systemPackages = with pkgs; [ zlib-ng home-assistant-cli ];

    services = {
      mosquitto = {
        enable = true;
        listeners = [
          {
            acl = [ "pattern readwrite #" ];
            omitPasswordAuth = true;
            settings.allow_anonymous = true;
          }
        ];
      };

      zigbee2mqtt = {
        enable = true;
        settings = {
          homeassistant = config.services.home-assistant.enable;
          permit_join = false;
          mqtt = {
            server = "mqtt://127.0.0.1:1883";
            base_topic = "zigbee2mqtt";
          };
          frontend.port = 8090;
          serial = {
            port = cfg.serialPortZigbee2Mqtt;
            adapter = "deconz";
          };
        };
      };

      home-assistant = {
        enable = true;

        extraComponents = [
          "radarr"
          "sonarr"
          "apple_tv"
          "backup"
          "cast"
          "esphome"
          "ibeacon"
          "forked_daapd"
          "freebox"
          "google_translate"
          "ipp"
          "local_calendar"
          "ld2410_ble"
          "met"
          "mobile_app"
          "mqtt"
          "netatmo"
          "radio_browser"
          "roborock"
          "samsungtv"
          "tailscale"
          "telegram"
          "tuya"
          "wled"
          "yeelight"
          "zeroconf"
          "zha"
        ];

        extraPackages =
          ps: with ps; [
            isal
            kegtron-ble
            pychromecast
          ];

        customComponents = with pkgs.home-assistant-custom-components; [ adaptive_lighting ];

        customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
          button-card
          card-mod
          mini-graph-card
          mini-media-player
          multiple-entity-row
          mushroom
          pkgs.dafos.lovelace-auto-entities
          pkgs.dafos.lovelace-fold-entity-row
          pkgs.dafos.lovelace-layout-card
          pkgs.dafos.bubble-card
        ];

        config = {
          # Includes dependencies for a basic setup
          # https://www.home-assistant.io/integrations/default_config/
          default_config = { };

          homeassistant = {
            name = "MaisonDaf";
            unit_system = "metric";
          };

          lovelace.mode = "yaml";
          lovelace.resources = [
            {
              url = "/local/nixos-lovelace-modules/mushroom.js";
              type = "module";
            }
            {
              url = "/local/nixos-lovelace-modules/bubble-card.js";
              type = "module";
            }
            {
              url = "/local/nixos-lovelace-modules/layout-card.js";
              type = "module";
            }
            {
              url = "/local/nixos-lovelace-modules/card-mod.js";
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

          zha = {
            zigpy_config = {
              device = cfg.serialPort;
            };
          };

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
            ];
          };
        };
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        80
        443
        8123
      ];
    };
  };
}
