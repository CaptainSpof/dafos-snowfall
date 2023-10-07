{ lib, ... }:

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

    git = {
      username = mkOpt types.str "CaptainSpof" "The name to configure git with.";
      email = mkOpt types.str "captain.spof@gmail.com" "The email to configure git with.";
    };
  };

}
