{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.tools.misc;
in
{
  options.${namespace}.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      coreutils
      curl
      duf
      fd
      file
      findutils
      fzf
      jq
      killall
      lsof
      pciutils
      procs
      unrar
      unzip
      wget
      xclip
    ];
  };
}
