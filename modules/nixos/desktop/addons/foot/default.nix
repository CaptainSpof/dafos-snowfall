{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.desktop.addons.foot;
in
{
  options.dafos.desktop.addons.foot = with types; {
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
