{ stdenv, fetchgit, callPackage }:
let uuid = "compiz-windows-effect@hermes83.github.com";
in stdenv.mkDerivation {
  name = "compiz-windows-effect";
  src = fetchgit {
    url = "https://github.com/hermes83/compiz-windows-effect";
    rev = "db34d31dbf19c1f39ed0e2f81b4d369b70eed39b";
    sha256 = "1w32kp5d5bhf725l9ssa66zlwf8bas9dn6ikmfj8q6k39lcfi4qi";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
    sed -i "2i imports.gi.GIRepository.Repository.prepend_search_path('${
      callPackage ./libanimation.nix { }
    }/lib/girepository-1.0');" $out/share/gnome-shell/extensions/${uuid}/effectsNative.js
  '';
}
