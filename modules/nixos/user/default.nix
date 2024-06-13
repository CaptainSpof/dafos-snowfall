{ config, pkgs, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.user;
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
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon"
    {
      passthru = { fileName = cfg.icon.fileName; };
    } ''
    local target="$out/share/dafos-icons/user/${cfg.name}"
    mkdir -p "$target"

    cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  '';
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
  shell = pkgs.fish;
in
{
  options.${namespace}.user = {
    name = mkOpt types.str username "The name to use for the user account.";
    fullName = mkOpt types.str "Cédric Da Fonseca" "The full name of the user.";
    email = mkOpt types.str "dafonseca.cedric@gmail.com" "The email of the user for git.";
    home = mkOpt (types.nullOr types.str) dirs.home "The user's home directory.";

    gitEmail = mkOpt types.str "captain.spof@gmail.com" "The email of the user for git.";
    gitUsername = mkOpt types.str "CaptainSpof" "The username for git.";

    initialPassword = mkOpt types.str "omgchangeme"
      "The initial password to use when the user is first created.";
    icon = mkOpt (types.nullOr types.package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true
      "Whether or not to show an initial message when opening a new shell.";

    theme.dark =
      mkOpt types.str "Everforest Dark Soft" "Theme to use for the system.";
    theme.light =
      mkOpt types.str "Everforest Light Soft" "Theme to use for the system.";
    font.term = mkOpt types.str "Hack Nerd Font Mono"
      "Terminal Font to use for the system.";

    authorizedKeys = mkOpt (types.listOf types.str) [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7YCmRYdXWhNTGWWklNYrQD5gUBTFhvzNiis5oD1YwV daf@daftop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDU0z8wC6aL3EelbY83Ucj1+2TMKt+lKjQkzEH6jFaWu daf@dafoltop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILGBJKhslXRQ4Bt8Nu3/YK799UsUpzpP6sDVkVw36nLR daf@dafpi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM9pWuxUUYo7wwCIfMUkrlfyrpT4IDeWnqldrgm6TIl0 daf@dafbox"
    ] "The public keys to apply.";

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

    programs.fish.enable = true;

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

      extraGroups = [
        "input"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
