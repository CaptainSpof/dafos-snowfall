{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.blender;
in
{
  options.dafos.apps.blender = with types; {
    enable = mkBoolOpt false "Whether or not to enable Blender.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ blender ]; };
}
