{ stdenv, python2, python2Packages, fetchurl, pam }:
let outPath = placeholder "out";
in stdenv.mkDerivation rec {
  pname = "pam-python";
  version = "1.0.8";
  src = fetchurl {
    url =
      "https://downloads.sourceforge.net/project/pam-python/pam-python-1.0.8-1/pam-python-1.0.8.tar.gz";
    sha256 = "sha256-/GnXcX2wUJERUAqBBTSH+naE4b47fQritRlwtv3JGPY=";
  };
  buildInputs = [ python2 python2Packages.sphinx pam ];
  preBuild = ''
    patchShebangs .
    substituteInPlace src/Makefile --replace '-Werror' '-O -Werror=cpp'
  '';
  makeFlags = [ "PREFIX=${outPath}" "LIBDIR=${outPath}/lib/security" ];
}
