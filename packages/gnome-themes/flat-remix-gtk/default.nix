{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "e42c0b24365dd197cb70b9accb9689b91fbe083b";
    sha256 = "0lgnnwy77x8qvgda3qfc13nirw7rzb3l89k0pgvihmry74laks4p";
  };
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
