{ stdenv, fetchFromGitHub, qt5, mpv, aria2, lua, update-nix-fetchgit }: stdenv.mkDerivation {
  pname = "kikoplay";
  version = "unstable-2022-04-06";

  src = fetchFromGitHub {
    owner = "Protostars";
    repo = "KikoPlay";
    rev = "058724a57e1011c2dbd0e1fedb6a74eb3a6d7399";
    sha256 = "04m626qmykbf99dcsmk34bss0mbnnrr7w18mr7bqvq73fjhjcaqj";
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
