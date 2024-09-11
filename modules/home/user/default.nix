{
  lib,
  config,
  namespace,
  ...
}:

let
  inherit (lib)
    types
    mkIf
    mkDefault
    mkMerge
    ;
  inherit (lib.${namespace}) mkOpt;

  cfg = config.${namespace}.user;

  dirs = rec {
    config = "${home}/.config";
    documents = "${home}/Documents";
    downloads = "${home}/Downloads";
    home = "/home/${username}";
    music = "${home}/Music";
    org = "${sync}/Org";
    pictures = "${home}/Pictures";
    projects = "${home}/Projects";
    repositories = "${home}/Repositories";
    sync = "${home}/Sync";
    videos = "${home}/Videos";
  };
  username = "daf";
  home-directory = if cfg.name == null then null else "/home/${cfg.name}";
in
{

  options.${namespace}.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    name = mkOpt (types.nullOr types.str) (config.snowfallorg.user.name or "daf") "The user account.";

    fullName = mkOpt types.str "Cédric Da Fonseca" "The full name of the user.";
    email = mkOpt types.str "dafonseca.cedric@gmail.com" "The email of the user.";
    gitEmail = mkOpt types.str "captain.spof@gmail.com" "The email of the user for git.";
    gitUsername = mkOpt types.str "CaptainSpof" "The username for git.";

    theme.dark = mkOpt types.str "Everforest Dark Soft" "Dark theme to use for the system.";
    theme.light = mkOpt types.str "Everforest Light Soft" "Light theme to use for the system.";

    font.term = mkOpt types.str "Departure Mono" "Terminal Font to use for the system.";
    font.ui = mkOpt types.str "Inter" "UI Font to use for the system.";

    location.latitude = mkOpt types.str "48.85" "The latitude of the user.";
    location.longitude = mkOpt types.str "2.35" "The longitude of the user.";

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

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        inherit (dirs)
          documents
          music
          pictures
          videos
          ;
        download = dirs.downloads;
        templates = dirs.home;
        extraConfig = {
          XDG_PROJECTS_DIR = dirs.projects;
          XDG_REPOSITORIES_DIR = dirs.repositories;
          XDG_SYNC_DIR = dirs.sync;
          XDG_ORG_DIR = dirs.org;
        };
      };

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;

      };
    }
  ]);
}
