{ stdenv, fetchFromGitHub, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "ca70e0a984426816f3c54df037ec7f499efaabe4";
    sha256 = "0zq9dwiqhcxla52qd4c1yp2cya84b7cmjy1qyi213zb1i97gzjlw";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
