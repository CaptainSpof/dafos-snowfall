{ lib, unzip, libsForQt5 }:

libsForQt5.mkDerivation {
  name = "simple-overview-pager";

  src = ./SimpleOverviewPager.plasmoid;

  dontUnpack = true;
  dontWrapQtApps = true;

  nativeBuildInputs = [
    unzip
  ];

  buildInputs = with libsForQt5; [
    kcoreaddons
    kwindowsystem
    plasma-framework
    systemsettings
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/plasmoids
    plasmapkg2 --type plasmoid --install $src --packageroot $out/share/plasma/plasmoids

    runHook postInstall
  '';

  meta = with lib; {
    description = "A beautiful control centre widget for KDE Plasma directly inspired by the MacOS control centre.";
    homepage = "https://github.com/Prayag2/kde_controlcentre";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
