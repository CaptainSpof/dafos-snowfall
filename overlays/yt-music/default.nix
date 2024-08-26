{ ... }:

final: prev: {
  dafos = (prev.dafos or { }) // {
    yt-music = prev.makeDesktopItem {
      name = "YT Music";
      desktopName = "YT Music";
      genericName = "Music, from YouTube.";
      exec = ''${final.firefox-beta}/bin/firefox "https://music.youtube.com/?dafos.app=true"'';
      icon = ./icon.svg;
      type = "Application";
      categories = [
        "AudioVideo"
        "Audio"
        "Player"
      ];
      terminal = false;
    };
  };
}
