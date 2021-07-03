{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-dark-gtk";
  src = fetchgit {
    url = "https://github.com/jmattheis/gruvbox-dark-gtk";
    rev = "04221c1317bed7a765a09f5bb00a97765ce4a711";
    sha256 = "0bfnzmjqg9hil2023l8b0cjd7rkmskw3gi6l4qz78cwkj9fymnhz";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/themes/${name}
    cp -r * $out/share/themes/${name}
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
