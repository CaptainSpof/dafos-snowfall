{ config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = { fileName = defaultIconFileName; };

  };
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon" {
    passthru = { fileName = cfg.icon.fileName; };
  } ''
    local target="$out/share/dafos-icons/user/${cfg.name}"
    mkdir -p "$target"

    cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  '';
  dirs = rec {
    home = "/home/${config.dafos.vars.username}";
    documents = "${home}/Documents";
    downloads = "${home}/Downloads";
    music = "${home}/Music";
    pictures = "${home}/Pictures";
    videos = "${home}/Videos";
    projects = "${home}/Projects";
    repositories = "${home}/Repositories";
    sync = "${home}/Sync";
    org = "${sync}/Org";
  };
  username = config.dafos.vars.username;
  shell = config.dafos.vars.shell;
in {
  imports = [ ../../vars.nix ];

  options.dafos.user = {
    name = mkOpt types.str username "The name to use for the user account.";

    initialPassword = mkOpt types.str "omgchangeme"
      "The initial password to use when the user is first created.";
    icon = mkOpt (types.nullOr types.package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true
      "Whether or not to show an initial message when opening a new shell.";

    extraGroups =
      mkOpt (types.listOf types.str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt types.attrs { }
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    environment.systemPackages = with pkgs; [
      fd
      fortune
      lolcat
      propagatedIcon
    ];

    dafos.home = {
      extraOptions = {
        xdg.userDirs = {
          enable = true;
          createDirectories = true;
          documents = dirs.documents;
          download = dirs.downloads;
          music = dirs.music;
          pictures = dirs.pictures;
          videos = dirs.videos;
          templates = dirs.home;
          extraConfig = {
            XDG_PROJECTS_DIR = dirs.projects;
            XDG_REPOSITORIES_DIR = dirs.repositories;
            XDG_SYNC_DIR = dirs.sync;
            XDG_ORG_DIR = dirs.org;
          };
        };

      };
    };

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;
      inherit (dirs) home;
      inherit shell;

      group = "users";

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      extraGroups = [ ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
