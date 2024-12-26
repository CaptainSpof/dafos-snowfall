{
  config,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.wezterm;
  fontTerm = config.${namespace}.user.font.mono; # TODO
in
{
  options.${namespace}.programs.terminal.emulators.wezterm = {
    enable = mkBoolOpt false "Whether or not to enable wezterm.";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      extraConfig = ''
        local wezterm = require("wezterm")
        return {

          -- general
          audible_bell = "Disabled",
          check_for_updates = false,
          enable_scroll_bar = false,
          exit_behavior = "CloseOnCleanExit",
          window_close_confirmation = "NeverPrompt",
          warn_about_missing_glyphs =  false,
          term = "wezterm",
          default_prog = { "fish" },

          -- Cursor
          cursor_blink_ease_in = 'Constant',
          cursor_blink_ease_out = 'Constant',
          cursor_blink_rate = 700,
          default_cursor_style = "BlinkingUnderline",

          -- Color scheme
          color_scheme = 'Gruvbox Material (Gogh)',

          -- Font
          font_size = 14.0,
          font = wezterm.font_with_fallback {
            { family = '${fontTerm}', weight = "Regular" },
            { family = 'MonaspiceKr Nerd Font', weight = "Regular" },
            { family = "Symbols Nerd Font", weight = "Regular" },
            { family = 'Noto Color Emoji', weight = "Regular" },
          },

          -- Tab bar
          enable_tab_bar = true,
          hide_tab_bar_if_only_one_tab = true,
          show_tab_index_in_tab_bar = false,
          tab_bar_at_bottom = true,
          use_fancy_tab_bar = false,
          -- try and let the tabs stretch instead of squish
          tab_max_width = 10000,

          -- perf
          enable_wayland = true,
          front_end = "WebGpu",
          scrollback_lines = 10000,

          -- term window settings
          window_background_opacity = 0.70,
          window_decorations = 'RESIZE',
          -- window_padding = { left = 12, right = 12, top = 12, bottom = 12, },
        }
      '';
    };
  };
}
