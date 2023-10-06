{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.tools.k8s;
in
{
  options.dafos.tools.k8s = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common Kubernetes utilities.";
  };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = {
      k = "kubecolor";
      kubectl = "kubecolor";
      kc = "kubectx";
      kn = "kubens";
      ks = "kubeseal";
    };

    environment.systemPackages = with pkgs; [
      kubectl
      kubectx
      kubeseal
      kubecolor
      kubernetes-helm
      helmfile
    ];
  };
}
