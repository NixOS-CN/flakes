{ stdenv, fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "0772c4059217c0c35dbf2762308d3da5cb56a918";
    sha256 = "1k60gr105ijkn1pvgp04csy22f5ad7qbbkvzx5z6jlwflxy9f477";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
}
