{ stdenv, fetchgit, callPackage, update-nix-fetchgit }:
let uuid = "compiz-windows-effect@hermes83.github.com";
in stdenv.mkDerivation {
  name = "compiz-windows-effect";
  src = fetchgit {
    url = "https://github.com/hermes83/compiz-windows-effect";
    rev = "41128b24cba39701fcd1e03ae1733e02df2bcf2d";
    sha256 = "0n67jki5dzf0qj6k45d1l2m6lb6mlq523n3ypy5pgdppq8hpv7g9";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
    sed -i "/use strict/a imports.gi.GIRepository.Repository.prepend_search_path('${
      callPackage ./libanimation.nix { }
    }/lib/girepository-1.0');" $out/share/gnome-shell/extensions/${uuid}/effects*.js
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
