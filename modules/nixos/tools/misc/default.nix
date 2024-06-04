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
    dafos.home.configFile."wgetrc".text = "";

    environment.systemPackages = with pkgs; [
      duf
      fd
      file
      fzf
      jq
      killall
      procs
      unzip
      unrar
      wget
    ];

    dafos.home.extraOptions = {
      programs.less = {
        enable = true;
        keys = ''
          c   next-tag
          C   prev-tag
          t   forw-line
          s   back-line
          T   forw-scroll
          S   back-scroll
        '';
      };
    };
  };
}
