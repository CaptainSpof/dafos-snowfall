{ config, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.bandwhich;
in
{
  options.${namespace}.cli-apps.bandwhich = {
    enable = mkBoolOpt false "Whether or not to enable bandwhich.";
  };

  config = mkIf cfg.enable {
    programs.bandwhich = {
      enable = true;
    };
  };
}
