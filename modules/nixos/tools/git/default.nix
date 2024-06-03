{ config, pkgs, lib, namespace, ... }:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.git;
  user = config.${namespace}.user;
in
{
  options.${namespace}.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str user.gitUsername "The name to configure git with.";
    userEmail = mkOpt types.str user.gitEmail "The email to configure git with.";
    # FIXME: setup ssh keys
    signingKey =
      mkOpt types.str "" "The key ID to sign commits with.";
    signByDefault = mkOpt types.bool false "Whether to sign commits by default.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    dafos.home.extraOptions = {
      programs.git = {
        enable = true;
        inherit (cfg) userName userEmail;
        lfs = enabled;
        signing = {
          key = cfg.signingKey;
          inherit (cfg) signByDefault;
        };
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { whitespace = "trailing-space,space-before-tab"; };
          safe = {
            directory = "${config.users.users.${user.name}.home}/.config.${namespace}";
          };
        };
      };
    };
  };
}
