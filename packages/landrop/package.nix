{ fontconfig, freetype, xorg, libsodium, qmake, wrapQtAppsHook, stdenv
, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  pname = "LANDrop";
  version = "2021-06-10";
  src = fetchFromGitHub {
    owner = "LANDrop";
    repo = "LANDrop";
    rev = "0c10dc86e7dee4ec897bb3b27a32caee2ba8f9de";
    sha256 = "1ddylrsadh4wi7rwbxpxji9153vpr0qy6hpfk2v4fsqj6f36j2r3";
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
