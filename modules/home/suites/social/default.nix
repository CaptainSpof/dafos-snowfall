{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
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
        discord = enabled;
        element = disabled;
        telegram = enabled;
        teamspeak = enabled;
      };
    };
  };
}
