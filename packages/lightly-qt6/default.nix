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
    rev = "c281ad6705e9eec471ebcd5099131ea50d27c1ec";
    sha256 = "sha256-cBICf6DGg6s7vbqJZ/zo09Wjkvm/ztQCDB8XLoXL7S8=";
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
