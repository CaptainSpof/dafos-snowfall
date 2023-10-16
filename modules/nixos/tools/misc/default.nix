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
      fd
      file
      fzf
      jq
      killall
      unzip
      wget
    ];

    dafos.home.extraOptions = {
      programs.ripgrep = {
        enable = true;
        arguments = ["--smart-case"];
      };

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
