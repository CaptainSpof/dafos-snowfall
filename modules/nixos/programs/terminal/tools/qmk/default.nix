{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.qmk;
in
{
  options.${namespace}.programs.terminal.tools.qmk = {
    enable = mkBoolOpt false "Whether or not to enable QMK";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qmk ];

    services.udev.packages = with pkgs; [ qmk-udev-rules ];
  };
}
