{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.apps.logseq;
in
{
  options.dafos.apps.logseq = with types; {
    enable = mkBoolOpt false "Whether or not to enable logseq.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ logseq ]; };
}
