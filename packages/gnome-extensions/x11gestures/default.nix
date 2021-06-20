{ stdenv, fetchgit, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "140ebb5e2d064aaf44b740ead53f672d1c30552e";
    sha256 = "1q7n0arq6gnl0hzmk0qww1gfz0fn4la4vrdgn6p0rmn9nhchp1vj";
  };

  nativeBuildInputs = [ glib.dev ];

  buildPhase = ''
    glib-compile-schemas schemas
  '';

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
    cp -r COPYING COPYRIGHT extension.js prefs.js convenience.js metadata.json src schemas \
    $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
  '';

  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
