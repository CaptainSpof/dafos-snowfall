{ lib, config, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.cli-apps.zellij;
in {
  options.${namespace}.cli-apps.zellij = { enable = mkEnableOption "Zellij"; };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      settings = {
        auto_layouts = true;
        default_layout = "compact"; # or compact

        ui.pane_frames = {
          rounded_corners = true;
          hide_session_name = true;
        };

        # load internal plugins from built-in paths
        plugins = {
          tab-bar.path = "tab-bar";
          status-bar.path = "status-bar";
          strider.path = "strider";
          compact-bar.path = "compact-bar";
        };
      };
    };

    home.file.".config/zellij" = {
      source = ./config;
      recursive = true;
    };
  };
}
