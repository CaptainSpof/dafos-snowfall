{
  lib,
  fetchFromGitHub,
  extra-cmake-modules,
  kdePackages,
}:

kdePackages.mkKdeDerivation {
  pname = "lightly-qt6";
  version = "0.5.7";

  src = fetchFromGitHub {
    owner = "Bali10050";
    repo = "Lightly";
    rev = "a455a2d1c0b158f5c26c5a3eec15d577901094f3";
    sha256 = "sha256-imFBAaLLa1yJn8FKfm6DRcRR1acxYmpJULU0Vl1bLMQ=";
  };

  extraBuildInputs = [
    kdePackages.kdecoration
    kdePackages.qtbase
    kdePackages.plasma-workspace
    extra-cmake-modules
  ];

  meta = {
    description = "A modern style for qt applications.";
    homepage = "https://github.com/Bali10050/Lightly";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
