{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua, update-nix-fetchgit }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "unstable-2022-04-04";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "bd344c96980c0d73efbe537f31e02611c488d6ed";
    sha256 = "1p65485vxflf1qlz0012k698m9h9nbp7hw6wa56pwwayww0jvgxr";
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
