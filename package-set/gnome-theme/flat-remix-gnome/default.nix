{ stdenv, fetchFromGitHub, glib }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "fe2adb1720832aa954539d5c221212efe0b445d2";
    sha256 = "00djr54asl2ki8xk8482z6f8vdpi73l552fbdlw0yhnq1l91fkgj";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
}
