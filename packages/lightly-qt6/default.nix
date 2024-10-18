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
    rev = "459466f7a845d0f98a82796418d8ebb03b7e5cbd";
    sha256 = "sha256-n4w6uMnBWNPwVE3vjTHGbzU9M6XgRafddkdxA7SafgQ=";
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
