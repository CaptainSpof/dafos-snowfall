{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.apps.krita;
in
{
  options.${namespace}.apps.krita = with types; {
    enable = mkBoolOpt false "Whether or not to enable krita.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ krita ]; };
}
