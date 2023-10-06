{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.services.printing;
in
{
  options.dafos.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable { services.printing.enable = true; };
}
