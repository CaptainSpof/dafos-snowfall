{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.art;
in
{
  options.dafos.suites.art = with types; {
    enable = mkBoolOpt false "Whether or not to enable art configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        # TODO: add krita
        gimp = enabled;
        inkscape = disabled;
        blender = disabled;
      };
    };
  };
}
