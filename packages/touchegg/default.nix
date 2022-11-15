{ libinput
, cairo
, systemd
, xorg
, pugixml
, gtk3
, glib
, stdenv
, lib
, cmake
, pkg-config
, fetchFromGitHub
, update-nix-fetchgit }:
let
  out = placeholder "out";
in
stdenv.mkDerivation {
  pname = "touchegg";
  version = "unstable-2022-11-14";

  src = fetchFromGitHub {
    owner = "JoseExposito";
    repo = "touchegg";
    rev = "e7577a22fbce1e42634c8a16c6cb2b39a377e0f6";
    sha256 = "1lr751g8bnz096g6bqqjdzqqlqip6q8bmk33bmpzwhv3sf2gwgd3";
  };

  preConfigure = ''
    sed -e '/pkg_get_variable(SYSTEMD_SERVICE_DIR systemd systemdsystemunitdir)/d' -i CMakeLists.txt
  '';

  buildInputs = with xorg; [
    pkg-config
    libinput
    cairo
    systemd
    libX11
    libXi
    libXrandr
    libXtst
    pugixml
    gtk3
    glib
    cmake
  ];
  cmakeFlags = [ "-DSYSTEMD_SERVICE_DIR=${out}/lib/systemd/system" ];

  postInstall = ''
    substituteInPlace ${out}/etc/xdg/autostart/touchegg.desktop \
      --replace "Exec=touchegg" "Exec=${out}/bin/touchegg"
  '';

  meta = {
    homepage = "https://github.com/JoseExposito/touchegg";
    description = "Linux multi-touch gesture recognizer";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
