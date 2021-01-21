{ python3Packages, libarchive, openssl }:
with python3Packages;
buildPythonApplication rec {
  pname = "opendrop";
  version = "0.12.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-GemKhhHVfYJftNB9NAwgql1uX/aao6i0//wscOFD0+E=";
  };

  buildInputs = [ libarchive openssl ];
  propagatedBuildInputs = [ setuptools requests zeroconf pillow requests-toolbelt libarchive-c (callPackage ./fleep.nix {}) ];

  preConfigure = ''
    substituteInPlace opendrop/config.py --replace '"openssl"' '"${openssl}/bin/openssl"'
  '';

  doCheck = false;

  meta.description = "An open Apple AirDrop implementation written in Python";
}
