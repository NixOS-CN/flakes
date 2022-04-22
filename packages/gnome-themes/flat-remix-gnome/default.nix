{ stdenv, fetchFromGitHub, glib, dconf, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "25f4e28879ed929b9a9ef94bd57dc73f9107f3c5";
    sha256 = "02d74jb52a2qs84gcq2p50q3na1in43w2mgi35y6k2slm3m715p1";
  };
  buildInputs = [ glib.dev dconf ];
  makeFlags = [ "DESTDIR=dist" ];
  postInstall = ''
    mkdir -p $out/share/
    mv dist/usr/share/flat-remix-gnome/themes $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
