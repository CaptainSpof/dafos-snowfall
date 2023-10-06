{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.emulation;
in
{
  options.dafos.suites.emulation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable emulation configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      apps = {
        yuzu = enabled;
        pcsx2 = disabled;
        dolphin = enabled;
      };
    };
  };
}
