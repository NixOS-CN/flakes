{ stdenv, fetchgit, callPackage, update-nix-fetchgit }:
let uuid = "compiz-windows-effect@hermes83.github.com";
in stdenv.mkDerivation {
  name = "compiz-windows-effect";
  src = fetchgit {
    url = "https://github.com/hermes83/compiz-windows-effect";
    rev = "d72dd59a209ce4d138b0809931ac72d2520892a4";
    sha256 = "03lxjdij2mzp1almzcwavgk489n252r01f1k030gnb2phgzibjlb";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
    sed -i "/use strict/a imports.gi.GIRepository.Repository.prepend_search_path('${
      callPackage ./libanimation.nix { }
    }/lib/girepository-1.0');" $out/share/gnome-shell/extensions/${uuid}/effects*.js
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *.nix";
}
