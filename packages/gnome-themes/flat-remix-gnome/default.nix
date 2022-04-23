{ stdenv, fetchFromGitHub, glib, dconf, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "f017462578b032a2fe973f2ef7927bfd9bae5104";
    sha256 = "1jhg9qvb83ssybbv0ky7yp2lgq95ybpcla0abkd4xi8r32ncpf9y";
  };
  buildInputs = [ glib.dev dconf ];
  makeFlags = [ "DESTDIR=dist" ];
  postInstall = ''
    mkdir -p $out/share/
    mv dist/usr/share/flat-remix-gnome/themes $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
