{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.dafos.tools.ssh;
in
{
  options.dafos.tools.ssh = {
    enable = mkEnableOption "SSH";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      extraConfig = ''
        Host *
          HostKeyAlgorithms +ssh-rsa
      '';
    };
  };
}
