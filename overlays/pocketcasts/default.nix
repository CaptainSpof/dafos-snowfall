{ ... }:

final: prev: {
  dafos = (prev.dafos or { }) // {
    pocketcasts = prev.makeDesktopItem {
      name = "Pocketcasts";
      desktopName = "Pocketcasts";
      genericName = "It’s smart listening, made simple.";
      exec = ''${final.firefox-beta}/bin/firefox "https://play.pocketcasts.com/podcasts?dafos.app=true"'';
      icon = ./icon.svg;
      type = "Application";
      categories = [
        "Network"
        "Feed"
        "AudioVideo"
        "Audio"
        "Player"
      ];
      terminal = false;
    };
  };
}
