{ lib, config, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.syncthing;
  user = config.${namespace}.user.name;
  home = config.${namespace}.user.home;

  dafbox.id   = "MG2JJVN-X3EQTRB-33WPAOV-OLMPVOC-PL2J2EL-GPNLXTA-BLDU6YK-ONUVJQ3";
  dafoltop.id = "7AOREJR-3BX2E3F-6WMRZRK-AWD4GKS-GZXTACF-EY3ZINT-IRQVL4I-25JYZQP";
  dafphone.id = "2RY63N4-F3XSFO7-CUZRJD2-KEIM4QT-AAQINLH-QLLPJ2Z-CC7MN3A-J5YDQA3";
  daftop.id   = "QUWBY5V-V7TFQHJ-N6DSROW-TE53IXD-RVDUJZV-5XGHNIA-PLPIUW7-BEHMGAQ";
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
      devices = { inherit dafbox dafoltop dafphone daftop; };
      folders = {
        "Test" = {
          path = "${home}/Sync/Test";
          devices = [  "dafbox" "dafoltop" "dafphone" "daftop" ];
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
