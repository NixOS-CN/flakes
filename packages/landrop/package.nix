{ fontconfig, freetype, xorg, libsodium, qmake, wrapQtAppsHook, stdenv
, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  pname = "LANDrop";
  version = "2021-06-08";
  src = fetchFromGitHub {
    owner = "LANDrop";
    repo = "LANDrop";
    rev = "ee8144a29f6945b4ba24d33fef81816629364e4d";
    sha256 = "1sxxf7jz4fbw3wf59parxjabn62plrq4vmhwgfx34i9gdih48x82";
  };

  nativeBuildInputs = [ qmake wrapQtAppsHook ];
  buildInputs = with xorg; [
    fontconfig
    freetype
    libsodium
    libX11
    libXext
    libXfixes
    libXi
    libXrender
    libxcb
  ];

  preConfigure = ''
    cd ./LANDrop
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv ./LANDrop $out/bin/LANDrop
    mkdir -p $out/share
    mv ./icons $out/share/icons
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
