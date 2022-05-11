{ stdenv, fetchFromGitHub, glib, dconf, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "0ccb5a3f073a4c428c6516003a4dd2a428e9ede7";
    sha256 = "07izqmlgarih608m6dajsda1pi84wph3ygaw5r2b1sy3534wr627";
  };
  buildInputs = [ glib.dev dconf ];
  makeFlags = [ "DESTDIR=dist" ];
  postInstall = ''
    mkdir -p $out/share/
    mv dist/usr/share/flat-remix-gnome/themes $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
