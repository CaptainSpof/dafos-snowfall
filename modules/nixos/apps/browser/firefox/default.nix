{ config , lib , options , pkgs , namespace, ...}:

let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox =
    {
      enable = mkBoolOpt false "Whether or not to enable Firefox.";
    };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
