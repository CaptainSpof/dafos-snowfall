{
  lib,
  config,
  namespace,
  ...
}:

let
  cfg = config.${namespace}.services.tandoor;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.tandoor = {
    enable = mkEnableOption "Whether or not to configure tandoor.";
  };

  # TODO/MAYBE: create and setup a user
  config = mkIf cfg.enable {
    services.tandoor-recipes = {
      enable = true;
      port = 9090;
    };

    networking.firewall.allowedTCPPorts = [
      9090
    ];
  };
}
