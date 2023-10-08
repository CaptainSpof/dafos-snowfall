{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.services.espanso;
in
{
  options.dafos.services.espanso = with types; {
    enable = mkBoolOpt false "Whether or not to enable espanso.";
  };

  config = mkIf cfg.enable {

    dafos.home = {
      # configFile = {
      #   "wgetrc".text = "";
      # };

      extraOptions = {
        services.espanso = {
          enable = true;
          package = pkgs.espanso-wayland;
        };
      };
    };
  };
}
