{ stdenv, fetchgit, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "ca080985a570b94fcfd732f16344d115be9280bf";
    sha256 = "0dsvbv3jw4kbqsjkdnqa2km0qq8fvgxa73y1pay75h81gfx2qs82";
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
