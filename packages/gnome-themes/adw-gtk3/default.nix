{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "adw-gtk3";
  src = fetchgit {
    url = "https://github.com/lassekongo83/adw-gtk3.git";
    rev = "b206ff2b1dc45961c32c9034f5763410db12b903";
    sha256 = "01w9m9gkkq6s63lx9plgdcsyd1qfl3c83ba2xh56mzjfki2b2zf5";
  };

  installPhase = ''
    mkdir -p $out/share/themes/adw-gtk3
    cp -r * $out/share/themes/adw-gtk3
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
