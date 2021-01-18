{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "2020-10-21";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "ed853cf9f94c304f850747ca339801f13a90fbeb";
    sha256 = "1sl6njhah41x3b4zkbiz5hky7lqxjynz3d5lz90i1kiqiwi50iq8";
  };

  nativeBuildInputs = [ qt5.qmake qt5.wrapQtAppsHook ];
  buildInputs = [ mpv aria2 lua (qt5.callPackage ./qthttpengine.nix {}) ];

  preConfigure = ''
    substituteInPlace KikoPlay.pro \
      --replace '-llua5.3' '-llua' \
      --replace '/usr' '${placeholder "out"}'
  '';
}
