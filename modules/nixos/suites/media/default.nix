{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.suites.media;
in
{
  options.dafos.suites.media = with types; {
    enable = mkBoolOpt false "Whether or not to enable media configuration.";
  };

  config = mkIf cfg.enable { dafos = { apps = { freetube = disabled; }; }; };
}
