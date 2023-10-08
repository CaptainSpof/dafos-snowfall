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

    dafos.user.extraGroups = [ "input" ];

    dafos.home = {
      extraOptions = {
        services.espanso = {
          enable = true;
          package = pkgs.espanso-wayland;

          configs = {
            default = {
              keyboard_layout = {
                layout = "fr";
                variant = "bepo";
              };
            };
          };

          matches = {
            base = {
              matches = [
                {
                  trigger = ":now";
                  replace = "It's {{currentdate}} {{currenttime}}";
                }
              ];
            };
          };
        };
      };
    };
  };
}
