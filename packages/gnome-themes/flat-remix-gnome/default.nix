{ stdenv, fetchFromGitHub, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "e2d80270b8bbee50f567756aba1ef1e00fde67da";
    sha256 = "12i7h8lkmkg6s3xa9zf7vkdgwpi4v1993i4llyry9dmarkha41ah";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
