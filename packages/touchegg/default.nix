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
  version = "unstable-2023-02-06";

  src = fetchFromGitHub {
    owner = "JoseExposito";
    repo = "touchegg";
    rev = "ef2360ba8fba1a148d9e7c52df8c82dfa4f7648f";
    sha256 = "1jkzginfpv8wi3isaclr7iskc29va5hwygx1a5zjsx8wdlaxwigz";
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
