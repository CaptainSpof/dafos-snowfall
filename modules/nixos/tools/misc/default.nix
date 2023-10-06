{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.misc;
in
{
  options.dafos.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    dafos.home.configFile."wgetrc".text = "";

    environment.systemPackages = with pkgs; [
      duf
      file
      fzf
      jq
      killall
      unzip
      wget
    ];
  };
}
