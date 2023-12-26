{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "lovelace-auto-entities";
  version = "1.12.1";

  src = fetchFromGitHub {
    owner = "thomasloven";
    repo = "lovelace-auto-entities";
    rev = "refs/tags/${version}";
    hash = "sha256-yeIgE1YREmCKdjHAWlUf7RfDZfC+ww3+jR/8AdKtZ7U=";
  };

  dontBuild = true;

  installPhase = ''

    mkdir $out
    cp -v auto-entities.js $out/

  '';

  passthru.entrypoint = "auto-entities.js";

  meta = with lib; {
    description = "🔹Automatically populate the entities-list of lovelace cards";
    homepage = "https://github.com/thomasloven/lovelace-auto-entities";
    license = licenses.mit;
  };
}
