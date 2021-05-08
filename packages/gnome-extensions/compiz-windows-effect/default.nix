{ stdenv, fetchgit, callPackage }:
let uuid = "compiz-windows-effect@hermes83.github.com";
in stdenv.mkDerivation {
  name = "compiz-windows-effect";
  src = fetchgit {
    url = "https://github.com/hermes83/compiz-windows-effect";
    rev = "0b7d3db63bc87d415144f300d9a929116ff8b841";
    sha256 = "0109pwsn0xr27rs8gi2lk3pqhfh10wfhl3nmbwchrvdyp50kpbab";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
    sed -i "/use strict/a imports.gi.GIRepository.Repository.prepend_search_path('${
      callPackage ./libanimation.nix { }
    }/lib/girepository-1.0');" $out/share/gnome-shell/extensions/${uuid}/effects*.js
  '';
}
