{ lib, config, namespace, ... }:

let
  inherit (lib) types mkIf mkDefault mkMerge;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;

  home-directory =
    if cfg.name == null then
      null
    else
      "/home/${cfg.name}";
in
{

  options.${namespace}.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) (config.snowfallorg.user.name or "daf") "The user account.";

    fullName = mkOpt types.str "Cédric Da Fonseca" "The full name of the user.";
    email = mkOpt types.str "dafonseca.cedric@gmail.com" "The email of the user.";
    gitEmail = mkOpt types.str "captain.spof@gmail.com" "The email of the user for git.";
    gitUsername = mkOpt types.str "CaptainSpof" "The username for git.";

    theme.dark =
      mkOpt types.str "Everforest Dark Soft" "Theme to use for the system.";
    theme.light =
      mkOpt types.str "Everforest Light Soft" "Theme to use for the system.";
    font.term = mkOpt types.str "Hack Nerd Font Mono"
      "Terminal Font to use for the system.";

    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "dafos.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "dafos.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
