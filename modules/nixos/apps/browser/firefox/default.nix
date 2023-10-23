{ config , lib , pkgs , ...}:

let
  inherit (lib) types mkIf mkMerge;
  inherit (lib.dafos) mkBoolOpt mkOpt;

  cfg = config.dafos.apps.firefox;
  defaultSettings = {
    "accessibility.typeaheadfind.enablesound" = false;
    "accessibility.typeaheadfind.flashBar" = 0;
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "browser.bookmarks.autoExportHTML" = true;
    "browser.bookmarks.showMobileBookmarks" = true;
    "browser.meta_refresh_when_inactive.disabled" = true;
    "browser.newtabpage.activity-stream.default.sites" = "";
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing,DuckDuckGo,eBay,Wikipedia (en)";
    "browser.search.suggest.enabled" = false;
    "browser.sessionstore.warnOnQuit" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.ssb.enabled" = true;
    "browser.startup.homepage.abouthome_cache.enabled" = true;
    "browser.startup.page" = 3;
    "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "dom.storage.next_gen" = true;
    "dom.webgpu.enabled" = true;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "general.autoScroll" = false;
    "general.smoothScroll.msdPhysics.enabled" = true;
    "geo.enabled" = false;
    "geo.provider.use_corelocation" = false;
    "geo.provider.use_geoclue" = false;
    "geo.provider.use_gpsd" = false;
    "intl.accept_languages" = "en-US = en";
    "layers.acceleration.disabled" = true;
    "layout.css.has-selector.enabled" = true;
    "media.eme.enabled" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
    "svg.context-properties.content.enabled" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "userChrome.RegularMenuIcons-Enabled" = true;
    "userChrome.Tabs.Option2.Enabled" = true;
    "userChrome.DarkTheme.TabFrameType.Border.Enabled" = true;
    # "media.hardware-video-decoding.force-enabled" = true;
  } // (mkIf (config.dafos.desktop.plasma.enable) {
  # Allow to use Qt file picker
    "widget.use-xdg-desktop-portal" = true;
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "widget.use-xdg-desktop-portal.settings" = 1;
    "widget.use-xdg-desktop-portal.location" = 1;
    "widget.use-xdg-desktop-portal.mime-handler" = 1;
  });

in
{
  options.dafos.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
    extraConfig =
      mkOpt str "" "Extra configuration for the user profile JS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile.";
    userChrome =
      mkOpt str "" "Extra configuration for the user chrome CSS file.";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-browser-connector.enable = config.dafos.desktop.gnome.enable;

    dafos.home = {
      file = mkMerge [
        # Fix tridactyl & plasma integration
        (mkIf config.dafos.desktop.plasma.enable {
          ".mozilla/native-messaging-hosts".source = pkgs.symlinkJoin {
            name = "native-messaging-hosts";
            paths = [
              "${pkgs.plasma-browser-integration}/lib/mozilla/native-messaging-hosts"
              "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts"
            ];
          };
        })
        (mkIf config.dafos.desktop.gnome.enable {
          ".mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json".source = "${pkgs.chrome-gnome-shell}/lib/mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json";
        })
        {
          ".mozilla/firefox/${config.dafos.user.name}/chrome/" = {
            source = lib.cleanSourceWith {
              src = lib.cleanSource ./chrome/.;
            };

            recursive = true;
          };
        }
      ];

      extraOptions = {
        programs.firefox = {
          enable = true;

          package = pkgs.wrapFirefox pkgs.firefox-beta-unwrapped {
            cfg = {
              enableTridactylNative = true;
            };

            extraPolicies = {
              CaptivePortal = false;
              DisableFirefoxStudies = true;
              DisableFormHistory = true;
              DisablePocket = true;
              DisableTelemetry = true;
              DisplayBookmarksToolbar = false;
              DontCheckDefaultBrowser = true;
              FirefoxHome = {
                Pocket = false;
                Snippets = false;
              };
              PasswordManagerEnabled = false;
              # PromptForDownloadLocation = true;
              UserMessaging = {
                ExtensionRecommendations = false;
                SkipOnboarding = true;
              };
              ExtensionSettings = {
                "ebay@search.mozilla.org".installation_mode = "blocked";
                "amazondotcom@search.mozilla.org".installation_mode = "blocked";
                "bing@search.mozilla.org".installation_mode = "blocked";
                "ddg@search.mozilla.org".installation_mode = "blocked";
                "wikipedia@search.mozilla.org".installation_mode = "blocked";

                "frankerfacez@frankerfacez.com" = {
                  installation_mode = "force_installed";
                  install_url = "https://cdn.frankerfacez.com/script/frankerfacez-4.0-an+fx.xpi";
                };

                "magnolia_limited_permissions@12.34" = {
                  installation_mode = "force_installed";
                  install_url = "https://gitlab.com/magnolia1234/bpc-uploads/-/raw/master/bypass_paywalls_clean-3.2.3.0-custom.xpi";
                };

                "ATBC@EasonWong" = {
                  installation_mode = "force_installed";
                  install_url = "https://addons.mozilla.org/firefox/downloads/file/4159211/adaptive_tab_bar_colour-2.1.4.xpi";
                };

                "bento" = {
                  installation_mode = "force_installed";
                  install_url = "https://addons.mozilla.org/firefox/downloads/file/3787567/bento-1.7.xpi";
                };

              };
              Preferences = { };
            };
          };

          profiles.${config.dafos.user.name} = {
            inherit (cfg) extraConfig userChrome settings;
            id = 0;
            inherit (config.dafos.user) name;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              bitwarden
              darkreader
              org-capture # TODO: setup
              plasma-integration
              simple-tab-groups
              sponsorblock
              stylus
              tabcenter-reborn
              tridactyl
              ublock-origin
              user-agent-string-switcher
            ];
          };
        };

        # Tridactyl
        xdg.configFile."tridactyl/tridactylrc".source = ./tridactyl/tridactylrc;
        xdg.configFile."tridactyl/themes/everforest-dark.css".source = ./tridactyl/tridactyl_style_everforest.css;
      };
    };
  };
}
