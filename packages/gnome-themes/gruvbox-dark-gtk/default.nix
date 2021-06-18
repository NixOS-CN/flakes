{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-dark-gtk";
  src = fetchgit {
    url = "https://github.com/jmattheis/gruvbox-dark-gtk";
    rev = "9f46a26ac94585d44ebc4fadac40cec8210337e8";
    sha256 = "1gn8bkcaqx21jdrpc2cxv50lfzx4245jvhsxsrln6k2cryikbbqb";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/themes/${name}
    cp -r * $out/share/themes/${name}
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
