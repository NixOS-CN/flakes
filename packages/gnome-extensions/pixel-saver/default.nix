{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "e6f2b835d32ee7d9a0af1a9301e6ae41f1d11d34";
    sha256 = "0hw102a5q6zcb16y4q330bfwwn145pk7fhs55vci0jccc3fwgprs";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
