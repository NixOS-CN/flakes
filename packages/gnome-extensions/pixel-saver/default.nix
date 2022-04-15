{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "26ea0a3d3a138551cf96bb70c7a6629b57e16563";
    sha256 = "0g54jzmwz088y4fghnpm1xvhcx1v6hsnpvsamh7h5kf3a3000jac";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
