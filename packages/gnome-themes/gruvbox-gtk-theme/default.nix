{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-gtk-theme";
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "c3172d8dcba66f4125a014d280d41e23f0b95cad";
    sha256 = "1411mjlcj1d6kw3d3h1w9zsr0a08bzl5nddkkbv7w7lf67jy9b22";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
