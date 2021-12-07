{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua, update-nix-fetchgit }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "unstable-2021-12-06";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "a50e24bf82f37e6973edddbaf5ce91f9f0062779";
    sha256 = "1p6fjf5d5j7igpva3ipyidjjs3fgsn03fj6h6h7ip7b3f825g6fg";
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
