{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "steal-my-focus";
  src = fetchgit {
    url = "https://github.com/Ninlives/gnome-shell-extension-stealmyfocus";
    rev = "06da2000d37d1eb9e9c421987b7baaf7fb58d3c2";
    sha256 = "0qb1cmvlld4l6j5z8lvg56mqghai13y0n35fvbk6pkmma20a58n9";
  };

  dontBuild = true;
  installPhase = ''
    baseDir="$out/share/gnome-shell/extensions/steal-my-focus@kagesenshi.org"
    mkdir -p "$baseDir"
    cp *.js "$baseDir" 
    cp *.json "$baseDir"
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
