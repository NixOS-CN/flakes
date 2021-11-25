{ stdenv, fetchgit, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "68b2079cc3d2e9741407c7fe52c4451ad2744cc7";
    sha256 = "120almhkmc6ybifk59xdj27nisc93ajy40y1cxi9cr9w8ilawnbp";
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
