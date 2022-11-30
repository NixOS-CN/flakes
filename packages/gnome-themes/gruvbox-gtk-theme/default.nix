{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-gtk-theme";
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "840df45d2e3280ce537f75c0ce6d532411795bd9";
    sha256 = "1h4qzm9fgx905fvr7xp7vsd84w345g96q4664pi1w1vy8rld2qy7";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
