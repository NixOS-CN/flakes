{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "adw-gtk3";
  src = fetchgit {
    url = "https://github.com/lassekongo83/adw-gtk3.git";
    rev = "b624f0939f6b31c9f13efb7b27f0c70926675bb4";
    sha256 = "1588bx3y5f94s73ilay03cajbzv5kailjvlf4li0ysdj0y6r3afs";
  };

  installPhase = ''
    mkdir -p $out/share/themes/adw-gtk3
    cp -r * $out/share/themes/adw-gtk3
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
