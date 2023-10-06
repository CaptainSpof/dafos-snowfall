{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.music;
in
{
  options.dafos.suites.music = with types; {
    enable = mkBoolOpt false "Whether or not to enable music configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        amberol = enabled;
        bottles = enabled;
      };
    };
  };
}
