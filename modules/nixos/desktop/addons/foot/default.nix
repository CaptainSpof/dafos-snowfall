{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.desktop.addons.foot;
in
{
  options.${namespace}.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable Foot, a terminal emulator.";
  };

  config = mkIf cfg.enable {
    dafos.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };

    dafos.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
