{ config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.tools.git;
  user = config.dafos.user;
  vars = config.dafos.vars;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str vars.git.username "The name to configure git with.";
    userEmail = mkOpt types.str vars.git.email "The email to configure git with.";
    # FIXME?
    signingKey =
      mkOpt types.str "" "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    dafos.home.extraOptions = {
      programs.git = {
        enable = true;
        inherit (cfg) userName userEmail;
        lfs = enabled;
        # signing = {
        #   key = cfg.signingKey;
        #   signByDefault = mkIf gpg.enable true;
        # };
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { whitespace = "trailing-space,space-before-tab"; };
          safe = {
            directory = "${config.users.users.${user.name}.home}/work/config";
          };
        };
      };
    };
  };
}
