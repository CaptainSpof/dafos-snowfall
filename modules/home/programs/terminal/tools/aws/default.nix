{ config, lib, namespace, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.programs.terminal.tools.aws;
in
{
  options.${namespace}.programs.terminal.tools.aws = {
    enable = mkBoolOpt false "Whether or not to enable aws.";
  };

  config = mkIf cfg.enable {
    programs.awscli = {
      enable = true;
      package = pkgs.awscli2;
    };
  };
}
