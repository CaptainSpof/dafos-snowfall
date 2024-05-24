{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.tools.aws;
in
{
  options.${namespace}.tools.aws = with types; {
    enable = mkBoolOpt false "Whether or not to enable aws.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ awscli2 ];
  };
}
