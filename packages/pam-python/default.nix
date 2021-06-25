{ stdenv, python3, python3Packages, fetchurl, pam }:
let outPath = placeholder "out";
in stdenv.mkDerivation rec {
  pname = "pam-python";
  version = "1.0.8";
  src = fetchurl {
    url =
      "https://downloads.sourceforge.net/project/pam-python/pam-python-1.0.8-1/pam-python-1.0.8.tar.gz";
    sha256 = "sha256-/GnXcX2wUJERUAqBBTSH+naE4b47fQritRlwtv3JGPY=";
  };
  buildInputs = [ python3 python3Packages.sphinx pam ];
  preBuild = ''
    substituteInPlace src/setup.py --replace '/usr/bin/python2' '/usr/bin/python3'
    substituteInPlace src/test.py  --replace '/usr/bin/python2' '/usr/bin/python3'
    patchShebangs .
    substituteInPlace src/Makefile --replace '-Werror' '-O -Werror=cpp'
    substituteInPlace src/Makefile --replace \
      'cp build/lib.*/pam_python.so $(DESTDIR)$(LIBDIR)' \
      'cp build/lib.*/pam_python.*.so $(DESTDIR)$(LIBDIR)/pam_python.so'
  '';
  makeFlags = [ "PREFIX=${outPath}" "LIBDIR=${outPath}/lib/security" ];

  meta.description = "Enables PAM modules to be written in Python";
}
