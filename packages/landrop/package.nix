{ fontconfig, freetype, xorg, libsodium, qmake, wrapQtAppsHook, stdenv
, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  pname = "LANDrop";
  version = "unstable-2021-06-22";
  src = fetchFromGitHub {
    owner = "LANDrop";
    repo = "LANDrop";
    rev = "b9675d7b9df5f79b7c6ab4c7b37cabd1ad28328c";
    sha256 = "1igcj6aypc71d15hicf49dm4jgb36540c9b405m6crdj1qakb8ih";
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
