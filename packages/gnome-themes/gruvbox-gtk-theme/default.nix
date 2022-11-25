{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-gtk-theme";
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "52ea04f4218892a276e09d987fe6aaf9434b5cc7";
    sha256 = "015idzl3jz5kjz14yw58gs08mlbm5v2yxmas0kdv4bpgvhkb1lbq";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
