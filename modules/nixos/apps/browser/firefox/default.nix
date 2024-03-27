{ config , lib , options , pkgs , ...}:

let
  inherit (lib) mkIf mkMerge;
  inherit (lib.dafos) mkBoolOpt;

  cfg = config.dafos.apps.firefox;
in
{
  options.dafos.apps.firefox =
    {
      enable = mkBoolOpt false "Whether or not to enable Firefox.";
    };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
