{ libsForQt5, lib, fetchFromGitHub, extra-cmake-modules, cmake }:

# FIXME: plasmoid won't appear
libsForQt5.mkDerivation rec {
  name = "kde-controlcentre";
  pname = "kde_controlcentre";

  src = fetchFromGitHub {
    owner = "Prayag2";
    repo = pname;
    rev = "cbf5ea1aa7238f950a5e213caafcdf9cc64c720e";
    sha256 = "sha256-3go8Blnm6F5CN2KuxkPupHdquqWtBVp09XYTfcopk3k=";
  };

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = with libsForQt5; [
    kcoreaddons
    kdeclarative
    kdecoration
    plasma-framework
  ];

  meta = with lib; {
    description = "A beautiful control centre widget for KDE Plasma directly inspired by the MacOS control centre.";
    homepage = "https://github.com/Prayag2/kde_controlcentre";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
