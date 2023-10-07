{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let
  cfg = config.dafos.cli-apps.eza;
in
{
  options.dafos.cli-apps.eza = with types; {
    enable = mkBoolOpt false "Whether or not to enable Eza.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ eza ];

    dafos.home.extraOptions = {
      home.shellAliases = rec {
        eza = "eza --group-directories-first --git";
        ls = "${eza}";
        sl = "${eza}";
        l = "${eza} -blF --icons";
        ll = "${eza} -abghilmu --icons";
        llm = "${ll} --sort=modified";
        la = "LC_COLLATE=C ${eza} -ablF --icons";
        lt = "${eza} --tree";
        tree = "${eza} --tree";
      };
    };
  };
}
