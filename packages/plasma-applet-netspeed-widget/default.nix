{
  lib,
  stdenv,
  fetchFromGitHub,
  kdePackages,
  nix-update-script,
}:

stdenv.mkDerivation (_finalAttrs: {
  pname = "plasma-applet-netspeed-widget";
  version = "3.1";

  src = fetchFromGitHub {
    owner = "dfaust";
    repo = "plasma-applet-netspeed-widget";
    rev = "5f54d7515c8770a7e81f1edd6bab429ff0f5db21";
    hash = "sha256-lP2wenbrghMwrRl13trTidZDz+PllyQXQT3n9n3hzrg=";
  };

  propagatedUserEnvPkgs = with kdePackages; [ kconfig ];

  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/plasmoids/org.kde.netspeedWidget
    cp -r package/* $out/share/plasma/plasmoids/org.kde.netspeedWidget
    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = " Plasma 6 widget that displays the currently used network bandwidth";
    homepage = "https://github.com/dfaust/plasma-applet-netspeed-widget";
    license = lib.licenses.gpl2Plus;
    inherit (kdePackages.kwindowsystem.meta) platforms;
  };
})
