{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.video;
in
{
  options.dafos.suites.video = with types; {
    enable = mkBoolOpt false "Whether or not to enable video configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        pitivi = enabled;
        obs = enabled;
      };
    };
  };
}
