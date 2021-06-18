{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "811159c82498d0e77e4351b4177df9bf4b05958e";
    sha256 = "0yhgw6hq2fbzb45zq78d28knym4zv1v07rab26sgzykn1x3j6yjp";
  };
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
