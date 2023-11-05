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
    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = [
          "${./configuration.yaml}:/config/configuration.yaml"
          "home-assistant:/config"
        ];
        environment.TZ = vars.timezone;
        image = "ghcr.io/home-assistant/home-assistant:stable"; # Warning: if the tag does not change, the image will not be updated
        extraOptions = [
          "--cap-add=CAP_NET_RAW,CAP_NET_BIND_SERVICE"
          "--network=host"
          "--device=${cfg.serialPort}:${cfg.serialPort}"
        ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [ 80 443 8123 8883 ];
    };
  };
}
