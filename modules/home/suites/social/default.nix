{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkDefault mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

  cfg = config.${namespace}.suites.social;
in
{
  options.${namespace}.suites.social = {
    enable = mkBoolOpt false "Whether or not to enable social configuration.";
  };

  config = mkIf cfg.enable {
    dafos = {
      programs.graphical.instant-messengers = {
        discord = mkDefault enabled;
        element = mkDefault disabled;
        telegram = mkDefault enabled;
        teamspeak = mkDefault disabled;
      };
    };
  };
}
