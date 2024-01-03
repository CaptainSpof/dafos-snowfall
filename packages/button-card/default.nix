{ lib
, stdenvNoCC
, fetchFromGitHub
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "button-card";
  version = "4.1.1";

  src = fetchurl {
    url = "https://github.com/custom-cards/button-card/releases/download/v4.1.1/button-card.js";
    downloadToTemp = true;
    recursiveHash = true;
    hash = "sha256-qkZg6Cl7MBHs54F1TklqnWz75HzA1NiuDsD8+jIgZV8=";
    postFetch = ''
      install -D $downloadedFile $out/button-card.js
    '';
  };

  dontUnpack = true;
  # dontConfigure = true;
  # dontBuild = true;
  # dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r $src/button-card.js $out

    runHook postInstall
  '';

  passthru.entrypoint = "button-card.js";

  meta = with lib; {
    description = "❇️ Lovelace button-card for home assistant";
    homepage = "https://github.com/custom-cards/button-card";
    license = licenses.mit;
  };
}
