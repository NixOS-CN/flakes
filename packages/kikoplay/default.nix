{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua, update-nix-fetchgit }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "unstable-2022-02-21";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "4a01987a59d9032060cc1cfe3beafdbaf490ef3b";
    sha256 = "11i70dzq1j1fm91jmapg4sdcx8vq5jb296mnhxv392cxq5fvl5v3";
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
