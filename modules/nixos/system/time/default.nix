{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.system.time;
in
{
  options.dafos.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "Europe/Paris"; };
}
