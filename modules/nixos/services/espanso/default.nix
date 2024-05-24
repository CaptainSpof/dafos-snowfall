{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.espanso;
  email = config.${namespace}.user.email;
  gitEmail = config.${namespace}.user.gitEmail;
  fullName = config.${namespace}.user.fullName;
in
{
  options.${namespace}.services.espanso = with types; {
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
              key_delay = 5;
            };
          };

          matches = {
            email = {
              matches = [
                {
                  trigger = "@me";
                  replace = email;
                }
                {
                  trigger = "@cs";
                  replace = gitEmail;
                }
              ];
            };
            misc = {
              matches = [
                {
                  trigger = ":me";
                  replace = fullName;
                }
              ];
            };
            templates = {
              matches = [
                {
                  trigger = ":tick";
                  replace = ''
                    $|$
                    ---
                    **Refs:**
                    -
                  '';
                }
              ];
            };
            symbols = {
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
