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
      mkOpt types.str "tcp://192.168.0.46:6638"
        "The serial port to use with Zigbee2mqtt.";
  };

  config = mkIf cfg.enable {

    dafos.user.extraGroups = [ "hass" ];

    environment.systemPackages = with pkgs; [
      zlib-ng
      home-assistant-cli
      frigate # TODO: setup
    ];

    systemd.services.zigbee2mqtt = {
      partOf = [ "home-assistant.service" ];
      requiredBy = [ "home-assistant.service" ];
    };

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
          availability = true;
          advanced.transmit_power = 20;
          permit_join = false;
          mqtt = {
            server = "mqtt://127.0.0.1:1883";
            base_topic = "zigbee2mqtt";
          };
          frontend.port = 8090;
          serial = {
            adapter = "zstack";
            baudrate = 115200;
            port = cfg.serialPortZigbee2Mqtt;
          };
        };
      };

      home-assistant = {
        enable = true;

        extraComponents = [
          "apple_tv"
          "backup"
          "bluetooth"
          "bluetooth_adapters"
          "broadlink"
          "camera"
          "cast"
          "esphome"
          "forked_daapd"
          "freebox"
          "google"
          "google_generative_ai_conversation"
          "google_translate"
          "ibeacon"
          "ipp"
          "ld2410_ble"
          "local_calendar"
          "mealie"
          "met"
          "meteo_france"
          "mobile_app"
          "mqtt"
          "netatmo"
          "openai_conversation"
          "pocketcasts"
          "radarr"
          "radio_browser"
          "roborock"
          "samsungtv"
          "smartthings"
          "smlight"
          "sonarr"
          "kegtron"
          "tailscale"
          "telegram"
          "telegram_bot"
          "tplink"
          "tradfri"
          "tuya"
          "wled"
          "yeelight"
          "zeroconf"
          "zha"
        ];

        extraPackages =
          ps: with ps; [
            google-ai-generativelanguage
            isal
            pytapo
          ];

        customComponents = with pkgs.home-assistant-custom-components; [
          adaptive_lighting
          better_thermostat
          frigate
          samsungtv-smart
          spook
        ];

        customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
          atomic-calendar-revive
          bubble-card
          button-card
          card-mod
          decluttering-card
          hourly-weather
          light-entity-card
          mini-graph-card
          mini-media-player
          multiple-entity-row
          mushroom
          pkgs.dafos.lovelace-auto-entities
          pkgs.dafos.lovelace-fold-entity-row
          pkgs.dafos.lovelace-layout-card
          template-entity-row
          universal-remote-card
          vacuum-card
          weather-card
        ];

        config = {
          # Includes dependencies for a basic setup
          # https://www.home-assistant.io/integrations/default_config/
          default_config = { };

          homeassistant = {
            name = "MaisonDaf";
            unit_system = "metric";
            temperature_unit = "C";
          };

          lovelace.mode = "yaml";

          "automation manual" = [ ];
          "automation ui" = "!include automations.yaml";
          "scene ui" = "!include scenes.yaml";
          "script ui" = "!include_dir_merge_named scripts/";

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

    systemd.tmpfiles.rules = [
      "d /var/lib/hass 0775 hass hass -"
      "d /var/lib/hass/scripts 0775 hass hass -"
      "d /var/lib/hass/custom_templates 0775 hass hass -"
    ];

  };
}
