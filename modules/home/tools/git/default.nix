{ lib, config, ... }:

let
  inherit (lib) types mkEnableOption mkIf;
  inherit (lib.dafos) mkOpt enabled;

  cfg = config.dafos.tools.git;
  user = config.dafos.user;
  vars = config.dafos.vars;
in
{
  imports = [ ../../../vars.nix ];

  options.dafos.tools.git = {
    enable = mkEnableOption "Git";
    userName = mkOpt types.str vars.git.username "The name to configure git with.";
    userEmail = mkOpt types.str vars.git.email "The email to configure git with.";
    # FIXME: setup ssh keys
    signingKey =
      mkOpt types.str "" "The key ID to sign commits with.";
    signByDefault = mkOpt types.bool true "Whether to sign commits by default.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs = enabled;
      # signing = {
      #   key = cfg.signingKey;
      #   inherit (cfg) signByDefault;
      # };
      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
        push = { autoSetupRemote = true; };
        core = { whitespace = "trailing-space,space-before-tab"; };
        safe = {
          directory = "${user.home}/work/config";
        };
      };
    };
    programs.gh.enable = true;
  };
}
