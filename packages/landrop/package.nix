{ fontconfig, freetype, xorg, libsodium, qmake, wrapQtAppsHook, stdenv
, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  pname = "LANDrop";
  version = "2021-06-19";
  src = fetchFromGitHub {
    owner = "LANDrop";
    repo = "LANDrop";
    rev = "f21c794a6d4ebe49fc2bc1193a9710ea53c340a5";
    sha256 = "1c6ighixqadazjb4s97vr3pnwiqs1mb7k0in93my57bmjl68mh32";
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
