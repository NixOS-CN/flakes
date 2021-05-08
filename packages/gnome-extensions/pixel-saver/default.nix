{ stdenv, fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "1d788807439209f59324aa9f11228a5ee08265b8";
    sha256 = "0c6wfvqfhrzl4ac1j6bggymp1iqzimshny83brrhn2sv9ddwwdqp";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
}
