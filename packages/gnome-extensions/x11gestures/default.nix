{ stdenv, fetchgit, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "e4df9a7853a3142903d309048c883ffc3ebdf06e";
    sha256 = "1j6v6c0hyc57fyii9dfj5piqxxlycz9gmgm94jwlpv7i2d206h9m";
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

  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
