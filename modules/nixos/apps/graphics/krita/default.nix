{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.krita;
in
{
  options.dafos.apps.krita = with types; {
    enable = mkBoolOpt false "Whether or not to enable Krita.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ krita ]; };
}
