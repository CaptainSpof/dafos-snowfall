{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.system.xkb;
in
{
  options.dafos.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "fr";
      xkbVariant = "bepo";
      xkbOptions = "caps:escape";
    };
  };
}
