{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.aws;
in
{
  options.dafos.tools.aws = with types; {
    enable = mkBoolOpt false "Whether or not to enable aws.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ awscli2 ];
  };
}
