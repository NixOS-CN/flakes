{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-gtk-theme";
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Gruvbox-GTK-Theme";
    rev = "e3dae13f9241dedc366a9db810eabc830e332e1a";
    sha256 = "0m3bsfv76cj02q8393npswi157jqii35i99pkg1vin5azrw2wh9j";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r themes $out/share
    cp -r icons $out/share
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
