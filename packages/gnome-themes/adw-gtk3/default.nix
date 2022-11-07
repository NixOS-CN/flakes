{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "adw-gtk3";
  src = fetchgit {
    url = "https://github.com/lassekongo83/adw-gtk3.git";
    rev = "11fd41a0dd87c217cf5f081cf06c11a984e86afe";
    sha256 = "1d48df5ixlaw0pa5sxlf7a36prnmx95vby2s3zabm9lrg21sbc05";
  };

  installPhase = ''
    mkdir -p $out/share/themes/adw-gtk3
    cp -r * $out/share/themes/adw-gtk3
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
