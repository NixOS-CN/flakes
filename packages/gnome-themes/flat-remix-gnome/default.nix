{ stdenv, fetchFromGitHub, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "1446627d0bea588f5e731298aa485cf2ebde33e3";
    sha256 = "0lfqy241ybkx1j78011xkjaivvnivdvsjl2ma79fapayim4l9rrp";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
