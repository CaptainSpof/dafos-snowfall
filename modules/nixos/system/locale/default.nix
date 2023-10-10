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
    i18n.defaultLocale = vars.locale.default;

    i18n.extraLocaleSettings = {
      LC_MONETARY = vars.locale.alt;
      LC_MEASUREMENT = vars.locale.alt;
      LC_TIME = vars.locale.alt;
      LANG = vars.locale.default;
    };

    # REVIEW
    # console = { keyMap = mkForce "us"; };
  };
}
