{ lib, pkgs, ... }:

let
  inherit (lib) types;
  inherit (lib.dafos) mkOpt;
in
{
  options.dafos.vars = {
    fullname = mkOpt types.str "Cédric Da Fonseca" "The full name of the user";
    username = mkOpt types.str "daf" "The user account";

    email = mkOpt types.str "dafonseca.cedric@gmail.com" "The email to configure git with.";

    timezone = mkOpt types.str "Europe/Paris" "The timezone to use for the system.";
    locale = mkOpt types.str "en_US.UTF-8" "The locale to use for the system.";

    shell = mkOpt types.package pkgs.fish "The shell to use for the system.";
    theme.dark = mkOpt types.str "Everforest Dark Soft" "Theme to use for the system.";
    theme.light = mkOpt types.str "Everforest Light Soft" "Theme to use for the system.";

    font.term = mkOpt types.str "Hack Nerd Font Mono" "Terminal Font to use for the system.";

    git = {
      username = mkOpt types.str "CaptainSpof" "The name to configure git with.";
      email = mkOpt types.str "captain.spof@gmail.com" "The email to configure git with.";
    };
  };

}
