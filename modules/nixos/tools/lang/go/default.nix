{ config, pkgs, lib, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.tools.lang.go;
in
{
  options.dafos.tools.lang.go = with types; {
    enable = mkBoolOpt false "Whether or not to enable Go support.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ go gopls ];
      sessionVariables = {
        GOPATH = "$HOME/work/go";
      };
    };
  };
}
