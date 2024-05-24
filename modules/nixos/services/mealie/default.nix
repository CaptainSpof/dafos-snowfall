{ lib, config, namespace, ... }:

let
  cfg = config.${namespace}.services.mealie;

  username = config.${namespace}.user.name;
  inherit (lib) mkEnableOption mkIf;
in {
  options.${namespace}.services.mealie = {
    enable = mkEnableOption "Whether or not to configure Mealie";
  };

  config = mkIf cfg.enable { services.mealie = { enable = true; }; };
}
