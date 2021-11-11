{ stdenv, fetchFromGitHub, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "cae94831513200f7e49c9806f86deaab1d7223ec";
    sha256 = "1pn2fg9icyxbxgiw31b1ih7xcpl2p1gs0lnlqbqqfrykiiwkkyp3";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
