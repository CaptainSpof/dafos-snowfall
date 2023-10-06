{ options, config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.hardware.fingerprint;
in
{
  options.dafos.hardware.fingerprint = with types; {
    enable = mkBoolOpt false "Whether or not to enable fingerprint support.";
  };

  config = mkIf cfg.enable { services.fprintd.enable = true; };
}
