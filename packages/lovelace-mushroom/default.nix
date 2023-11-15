{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "lovelace-mushroom";
  version = "3.2.2";

  src = fetchFromGitHub {
    owner = "piitaya";
    repo = "lovelace-mushroom";
    rev = "refs/tags/v${version}";
    hash = "sha256-dVwQZ7T2Hq7pXfvE1uvnmaRh9w2ZMeJ01sf/YvGMQUM=";
  };

  npmDepsHash = "sha256-dXVePzHRmdgh6vW2azC12W1Z/vY0wMod3tjTpvFLY8M=";

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -v dist/mushroom.js $out/

    runHook postInstall
  '';

  passthru.entrypoint = "mushroom.js";

  meta = with lib; {
    description = "Mushroom Cards - Build a beautiful dashboard easily 🍄";
    homepage = "https://github.com/piitaya/lovelace-mushroom";
    license = licenses.gpl2;
  };
}
