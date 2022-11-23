{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-gtk-theme";
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "80c337c69a7cc04f38f84093858fe0c6f27ca8e3";
    sha256 = "1hpi388dkfc0ybx3khv757rynhqf261wkyjfvy247rzxrf78ldkb";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
