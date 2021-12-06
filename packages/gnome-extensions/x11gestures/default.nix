{ stdenv, fetchgit, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "f606183315d469e51665c0883bd05ce26402f9e7";
    sha256 = "046203x1iyhbbnpac77j4ixdxc578dr8m4573p15sj419z25fc2n";
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
