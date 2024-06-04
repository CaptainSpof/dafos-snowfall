{ config , lib , namespace, ...}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps._firefox;
in
{
  options.${namespace}.apps._firefox =
    {
      enable = mkBoolOpt false "Whether or not to enable firefox.";
    };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
