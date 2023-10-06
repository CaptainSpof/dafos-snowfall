{ config, lib, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.nix-ld;
in
{
  options.dafos.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-ld.";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
