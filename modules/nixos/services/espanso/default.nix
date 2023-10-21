{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.services.espanso;
  vars = config.dafos.vars;
in
{
  imports = [ ../../../vars.nix ];
  options.dafos.services.espanso = with types; {
    enable = mkBoolOpt false "Whether or not to enable espanso.";
  };

  config = mkIf cfg.enable {

    dafos.user.extraGroups = [ "input" ];

    # HACK: espanso fail to launch without this
    services.udev.packages = [ pkgs.logitech-udev-rules ];

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
              backend = "Inject";
              inject_delay = 5;
            };
          };

          matches = {
            email = {
              matches = [
                {
                  trigger = "@me";
                  replace = vars.email;
                }
                {
                  trigger = "@cs";
                  replace = vars.git.email;
                }
              ];
            };
            misc = {
              matches = [
                {
                  trigger = ":me";
                  replace = vars.fullname;
                }
              ];
            };
            symbols = {
              backend = "Clipboard";
              matches = [
                {
                  trigger = ":ar";
                  replace = "→";
                }
                {
                  trigger = ":al";
                  replace = "←";
                }
              ];
            };
          };
        };
      };
    };
  };
}
