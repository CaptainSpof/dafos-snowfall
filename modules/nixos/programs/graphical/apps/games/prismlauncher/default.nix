{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.apps.prismlauncher;
in
{
  options.${namespace}.apps.prismlauncher = {
    enable = mkBoolOpt false "Whether or not to enable Prism Launcher.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ prismlauncher ]; };
}
