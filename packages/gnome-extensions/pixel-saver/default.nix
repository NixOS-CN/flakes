{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "ace42b21d3df1e9e54067ecf23ef5c99b386a503";
    sha256 = "11s5hkdkn0smi6iw79l41r63jrix2w8l6g2gxp3ahz4hwj45bymc";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
