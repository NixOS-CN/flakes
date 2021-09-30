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
  version = "unstable-2021-09-29";

  src = fetchFromGitHub {
    owner = "JoseExposito";
    repo = "touchegg";
    rev = "bb9a602fc01ce279b00f1081d720b9aa08e24cff";
    sha256 = "1vddxjvxqbvbgzx4w3zk9wdrqahv9slf74m9jj6312y82lq3w0cs";
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
