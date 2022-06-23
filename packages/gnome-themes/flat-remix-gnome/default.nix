{ stdenv, fetchFromGitHub, glib, dconf, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "ecdf343ce0ad56cba9e42397a2f8719422a54d29";
    sha256 = "19d0bwzch6fnj8aqpdyrva85ck13gi56c3s9kq1bjk1sl8w5hvby";
  };
  buildInputs = [ glib.dev dconf ];
  makeFlags = [ "DESTDIR=dist" ];
  postInstall = ''
    mkdir -p $out/share/
    mv dist/usr/share/flat-remix-gnome/themes $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
