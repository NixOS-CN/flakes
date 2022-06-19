{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "adw-gtk3";
  src = fetchgit {
    url = "https://github.com/lassekongo83/adw-gtk3.git";
    rev = "35c5dc8cc2e3cd6c32332600ee3845f1d9c79a56";
    sha256 = "1bwzsp886nfm99wcpb95zsibw30miv90fa8rlc3lsiq2bxa187r0";
  };

  installPhase = ''
    mkdir -p $out/share/themes/adw-gtk3
    cp -r * $out/share/themes/adw-gtk3
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
