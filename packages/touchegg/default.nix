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
, pkgconfig
, fetchFromGitHub
, update-nix-fetchgit }:
let
  out = placeholder "out";
in
stdenv.mkDerivation {
  pname = "touchegg";
  version = "unstable-2022-03-30";

  src = fetchFromGitHub {
    owner = "JoseExposito";
    repo = "touchegg";
    rev = "c79856b6084ebbaf920494b5484f698e67895c80";
    sha256 = "1mnidycvgkpbnciij7dqzif1y1y6w71rmjj4kg3k0vl88ascbbak";
  };

  preConfigure = ''
    sed -e '/pkg_get_variable(SYSTEMD_SERVICE_DIR systemd systemdsystemunitdir)/d' -i CMakeLists.txt
  '';

  buildInputs = with xorg; [
    pkgconfig
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
    desciption = "Linux multi-touch gesture recognizer";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
