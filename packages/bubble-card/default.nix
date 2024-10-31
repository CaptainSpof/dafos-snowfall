{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "bubble-card";
  version = "2.2.4";

  src = fetchFromGitHub {
    owner = "Clooos";
    repo = "Bubble-Card";
    rev = "refs/tags/v${version}";
    hash = "sha256-vsgu1hvtlppADvaFLeB4xQHbP3wBc6H4p5HbeS3JY80=";
  };

  dontBuild = true;

  installPhase = ''

    mkdir $out
    install -m0644 dist/bubble-card.js $out
    install -m0644 dist/bubble-pop-up-fix.js $out

  '';

  meta = {
    description = "Bubble Card is a minimalist card collection for Home Assistant with a nice pop-up touch.";
    homepage = "https://github.com/Clooos/Bubble-Card";
    license = lib.licenses.mit;
  };
}
