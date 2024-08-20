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

  cfg = config.${namespace}.desktop.addons.swappy;
in
{
  options.${namespace}.desktop.addons.swappy = {
    enable = mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    dafos.home.configFile."swappy/config".source = ./config;
    dafos.home.file."Pictures/screenshots/.keep".text = "";
  };
}
