{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf getExe;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.koi;
in
{
  options.${namespace}.services.koi = {
    enable = mkBoolOpt false "Whether or not to enable koi.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.koi = {
      Unit = {
        Description = "koi";
        After = [ "plasma-workspace.target" ];
      };

      Install = {
        WantedBy = [ "plasma-workspace.target" ];
      };

      Service = {
        ExecStart = "${getExe pkgs.kdePackages.koi}";
        Restart = "on-failure";
      };
    };
  };
}
