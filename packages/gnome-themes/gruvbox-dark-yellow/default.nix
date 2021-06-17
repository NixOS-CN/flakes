{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gruvbox-dark-yellow-theme";
  src = fetchgit {
    url = "https://github.com/4rtzel/Gruvbox-Dark-Yellow.git";
    rev = "da38ec8c41cb88b7c4450c387960e12e4f5ac7fa";
    sha256 = "12z7q18ky0nw9j0hyqkn9h0si0b2wcx1izlz7bcfmils9dykflri";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/themes/Gruvbox-Dark-Yellow
    cp -r * $out/share/themes/Gruvbox-Dark-Yellow
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
