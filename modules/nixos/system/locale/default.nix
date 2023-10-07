{ config, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.system.locale;
  vars = config.dafos.vars;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = vars.locale;

    # REVIEW
    # console = { keyMap = mkForce "us"; };
  };
}
