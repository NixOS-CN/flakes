{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "steal-my-focus";
  src = fetchgit {
    url = "https://github.com/Ninlives/gnome-shell-extension-stealmyfocus";
    rev = "2d4d9228a1c4f5df66531721156d466425e14496";
    sha256 = "0sjrnb6q1zxipx23wc8j3sjkdqszd1kbi3rdrmjn2ynn2kq8l8lv";
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
