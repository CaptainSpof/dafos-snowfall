{
  lib,
  config,
  namespace,
  ...
}:

let
  cfg = config.${namespace}.services.sunshine;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.sunshine = {
    enable = mkEnableOption "Whether or not to configure sunshine.";
  };

  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
