{
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
}:

# Use this file either for nix-shell or for nix-build when developing locally.
# nix-shell -E 'with import <nixpkgs> {}; pkgs.libsForQt5.callPackage ./dev.nix {}'
# nix-build -E 'with import <nixpkgs> {}; pkgs.libsForQt5.callPackage ./dev.nix {}'

stdenv.mkDerivation {
  name = "koi";

  src = fetchFromGitHub {
    owner = "baduhai";
    repo = "Koi";
    rev = "894b3c03da50ceda7d866775eb937f08ae506283";
    sha256 = "sha256-kR+7Atm8exrpcw/0RevNZJIPYXmBNiRijKYdHkcYJcU=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = with kdePackages; [
    wrapQtAppsHook
    kcoreaddons
    kwidgetsaddons
    kconfig
  ];

  sourceRoot = "source/src";
}
