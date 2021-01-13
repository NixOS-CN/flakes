{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-dark-gtk";
  src = fetchgit {
    url = "https://github.com/jmattheis/gruvbox-dark-gtk";
    rev = "a02c2286855a7fea3d5f17e2257c78f961afc944";
    sha256 = "1j6080bvhk5ajmj7rc8sdllzz81iyafqic185nrqsmlngvjrs83h";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/themes/${name}
    cp -r * $out/share/themes/${name}
  '';
}
