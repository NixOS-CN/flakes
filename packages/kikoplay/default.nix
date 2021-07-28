{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua, update-nix-fetchgit }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "unstable-2021-06-18";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "1fb4e03562a261eb17d4bb06e67a1a744393dcf5";
    sha256 = "07gd2jr2hai9ckhll7qzyba4gf6pmbsjr8whasf2asxfrz9968qw";
  };

  nativeBuildInputs = [ qt5.qmake qt5.wrapQtAppsHook ];
  buildInputs = [ mpv aria2 lua (qt5.callPackage ./qthttpengine.nix {}) ];

  preConfigure = ''
    substituteInPlace KikoPlay.pro \
      --replace '-llua5.3' '-llua' \
      --replace '/usr' '${placeholder "out"}'
  '';

  meta.description = "KikoPlay - NOT ONLY A Full-Featured Danmu Player";
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
