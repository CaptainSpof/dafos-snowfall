{
  lib,
  fetchFromGitHub,
  extra-cmake-modules,
  kdePackages,
}:

kdePackages.mkKdeDerivation {
  pname = "lightly-qt6";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "Bali10050";
    repo = "Lightly";
    rev = "532779db035def3dd99917a4194c3eb40c69c4f6";
    sha256 = "sha256-UxtayqLgtFbClErjZWMBp3bBtSv31AQzP5dh3fk+d44=";
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
