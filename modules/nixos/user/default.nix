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
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon"
    { passthru = { fileName = cfg.icon.fileName; }; }
    ''
      local target="$out/share/dafos-icons/user/${cfg.name}"
      mkdir -p "$target"

      cp ${cfg.icon} "$target/${cfg.icon.fileName}"
    '';
  vars = config.dafos.vars;
in
{
  imports = [ ../../vars.nix];

  options.dafos.user = {
    name = mkOpt types.str vars.username "The name to use for the user account.";

    fullName = mkOpt types.str vars.fullname "The full name of the user.";
    email = mkOpt types.str vars.email "The email of the user.";

    initialPassword = mkOpt types.str "omgchangeme"
      "The initial password to use when the user is first created.";
    icon = mkOpt (types.nullOr types.package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";

    extraGroups = mkOpt (types.listOf types.str) [ ] "Groups for the user to be assigned.";
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
      file = {
        "Desktop/.keep".text = "";
        "Documents/.keep".text = "";
        "Downloads/.keep".text = "";
        "Music/.keep".text = "";
        "Pictures/.keep".text = "";
        "Videos/.keep".text = "";
        "work/.keep".text = "";
        ".face".source = cfg.icon;
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source = cfg.icon;
      };

      extraOptions = {
      };
    };

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = vars.shell;

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
