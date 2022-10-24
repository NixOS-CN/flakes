{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "adw-gtk3";
  src = fetchgit {
    url = "https://github.com/lassekongo83/adw-gtk3.git";
    rev = "952e5ad2eed40283b8edab726c7c669c63a76022";
    sha256 = "0iyrvia1z1kccby4g1x7n9bf32hc4ldhab3pb51jizf6xlcrflng";
  };

  installPhase = ''
    mkdir -p $out/share/themes/adw-gtk3
    cp -r * $out/share/themes/adw-gtk3
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
