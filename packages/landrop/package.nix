{ fontconfig, freetype, xorg, libsodium, qmake, wrapQtAppsHook, stdenv
, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  pname = "LANDrop";
  version = "2021-06-18";
  src = fetchFromGitHub {
    owner = "LANDrop";
    repo = "LANDrop";
    rev = "57b867db5513617a045dfcdd73365c04e320e1cc";
    sha256 = "0ll4sldyjnwpbm2cmzfj5cy0xr35fxqjdkv3936spvza3rmnhjga";
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
