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
  version = "unstable-2023-01-17";

  src = fetchFromGitHub {
    owner = "JoseExposito";
    repo = "touchegg";
    rev = "cc74aa88ec73e75d91bf6d4eecb5049bdd43fcb5";
    sha256 = "065gn39rvg030xpb46zas59zj12g5vq6q4gsjjpvxlmq2x8i9nc4";
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
