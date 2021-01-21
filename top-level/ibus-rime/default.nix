{ stdenv, fetchFromGitHub, cmake, pkgconfig, gdk-pixbuf, glib, ibus, libnotify
, librime, brise }:

stdenv.mkDerivation rec {
  pname = "ibus-rime";
  version = "2020-12-04";

  src = fetchFromGitHub {
    owner = "rime";
    repo = "ibus-rime";
    rev = "bfabe6722c1e20ee1ba33aa5107ed74934252705";
    sha256 = "sha256-KTlK5e6W6PZLZX5K3hDbTX6C2/Y246uTUzodqJEbk1k=";
  };

  buildInputs = [ gdk-pixbuf glib ibus libnotify librime brise ];
  nativeBuildInputs = [ cmake pkgconfig ];
  cmakeFlags = [ "-DRIME_DATA_DIR=${brise}/share/rime-data" ];

  # makeFlags = [ "PREFIX=$(out)" ];
  # dontUseCmakeConfigure = true;

  # prePatch = ''
  #   substituteInPlace Makefile \
  #      --replace 'cmake' 'cmake -DRIME_DATA_DIR=${brise}/share/rime-data'
  #    substituteInPlace rime_config.h \
  #      --replace '/usr' $out
  #    substituteInPlace rime_config.h \
  #      --replace 'IBUS_RIME_SHARED_DATA_DIR IBUS_RIME_INSTALL_PREFIX' \
  #                'IBUS_RIME_SHARED_DATA_DIR "${brise}"'
  #    substituteInPlace rime.xml \
  #      --replace '/usr' $out
  # '';

  meta = {
    description = "Rime for Linux/IBus";
    isIbusEngine = true;
  };

}
