{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "eafc1ae3a0332ae7cd69f28d66fa8f1848563757";
    sha256 = "0fwwf43ibbqd1qy18508fkwx30n4jdydwavzb01swfhgm38iq4gw";
  };
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
