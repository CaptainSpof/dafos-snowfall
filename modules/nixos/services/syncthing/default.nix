{ lib, config, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.services.syncthing;
    user = config.${namespace}.user.name;
    home = config.${namespace}.user.home;

    daftop.id = "QUWBY5V-V7TFQHJ-N6DSROW-TE53IXD-RVDUJZV-5XGHNIA-PLPIUW7-BEHMGAQ";

in
{
  options.${namespace}.services.syncthing = with types; {
    enable = mkBoolOpt false "Whether or not to configure syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;

      inherit user;
      configDir = "${home}/.config/syncthing";
      devices = {
        inherit daftop;
      };
      folders = {
        "Test" = {
          path = "${home}/Sync/Test";    # Which folder to add to Syncthing
          # devices = [ "device1" "device2" ];      # Which devices to share the folder with
        };
      };
    };

    # Syncthing ports: 8384 for remote access to GUI
    # 22000 TCP and/or UDP for sync traffic
    # 21027/UDP for discovery
    # source: https://docs.syncthing.net/users/firewall.html
    networking.firewall = {
      allowedTCPPorts = [ 8384 22000 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };
}
