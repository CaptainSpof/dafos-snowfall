{ lib
, fetchFromGitHub
, buildHomeAssistantComponent
, pkgs
}:

buildHomeAssistantComponent rec {
  pname = "adaptive-lighting";
  version = "1.19.1";

  src = fetchFromGitHub {
    owner = "basnijholt";
    repo = "adaptive-lighting";
    rev = "refs/tags/${version}";
    hash = "sha256-AZsloE1vNQ9o2pg878J6I5qYXyI4fqYEvr18SrTocWo=";
  };

  propagatedBuildInputs = with pkgs.python311Packages; [
    ulid-transform
  ];

  dontBuild = true;

  meta = with lib; {
    description = "Adaptive Lighting custom component for Home Assistant";
    license = licenses.gpl2;
  };
}
