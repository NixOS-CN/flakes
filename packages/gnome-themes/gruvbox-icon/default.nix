{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-icon";
  src = fetchgit {
    url = "https://www.opencode.net/adhe/gruvboxplasma.git";
    rev = "990c7c0a212ba8f845cfd28d8259ebdb35fc7d0a";
    sha256 = "08farrjcxf2l47cbqin7x6vcyjavha62pzki1wq4spfbiblgh9jp";
  };
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
