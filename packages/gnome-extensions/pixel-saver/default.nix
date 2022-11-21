{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "d8ae73cf8147bdf9ce458e785b174ad58a4fa689";
    sha256 = "1m9bzlwa948g0al8ahxipjlid5cddjk8qmr2dwdibj6dshl06njw";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
