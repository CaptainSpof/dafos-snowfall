{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.wshowkeys;
in
{
  options.dafos.cli-apps.wshowkeys = with types; {
    enable = mkBoolOpt false "Whether or not to enable wshowkeys.";
  };

  config = mkIf cfg.enable {
    dafos.user.extraGroups = [ "input" ];
    environment.systemPackages = with pkgs; [ wshowkeys ];
  };
}
