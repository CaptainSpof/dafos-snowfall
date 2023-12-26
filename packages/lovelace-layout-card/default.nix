{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "lovelace-layout-card";
  version = "2.4.4";

  src = fetchFromGitHub {
    owner = "thomasloven";
    repo = "lovelace-layout-card";
    rev = "refs/tags/${version}";
    hash = "sha256-/NKtzv1wWQNfwEYc0Y5It1NeBCU+Tg/jCYBB92uINT4=";
  };

  npmDepsHash = "sha256-HRQlmgzJF79hRGXwAXf4RluAJ/qK6nGk8qe67hAqnSc=";

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -v layout-card.js $out/

    runHook postInstall
  '';

  passthru.entrypoint = "layout-card.js";

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.gpl2;
  };
}
