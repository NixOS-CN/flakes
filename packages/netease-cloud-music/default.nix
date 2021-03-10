{ alsaLib, autoPatchelfHook, dpkg, e2fsprogs, fetchurl, fontconfig, freetype
, gdk-pixbuf, glib, harfbuzz, lib, libGL, libgpgerror, libusb, makeWrapper
, p11-kit, pango, qt5, stdenv, xorg, zlib }:
stdenv.mkDerivation rec {
  pname = "netease-cloud-music";
  version = "1.2.0";
  src = fetchurl {
    url =
      "http://d1.music.126.net/dmusic/netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb";
    sha256 = "1fzc5xb3h17jcdg8w8xliqx2372g0wrfkcj8kk3wihp688lg1s8y";
    curlOpts = "-A 'Mozilla/5.0'";
  };
  unpackCmd = "${dpkg}/bin/dpkg -x $src .";
  sourceRoot = ".";

  nativeBuildInputs = [ qt5.wrapQtAppsHook makeWrapper autoPatchelfHook ];
  buildInputs = [
    alsaLib
    e2fsprogs
    fontconfig.lib
    freetype
    gdk-pixbuf
    glib
    harfbuzz
    libGL
    libgpgerror
    libusb
    p11-kit
    pango
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtwebchannel
    stdenv.cc.cc.lib
    xorg.libX11
    zlib
  ];

  installPhase = ''
    mkdir -p $out/share
    cp -r usr/share/* $out/share

    mkdir -p $out/lib/netease-cloud-music
    cp -r opt/netease/netease-cloud-music/libs $out/lib/netease-cloud-music
    cp -r opt/netease/netease-cloud-music/plugins $out/lib/netease-cloud-music

    mkdir -p $out/bin
    cp opt/netease/netease-cloud-music/netease-cloud-music $out/bin/netease-cloud-music
  '';

  postFixup = ''
    wrapProgram $out/bin/netease-cloud-music \
      --set QT_PLUGIN_PATH  "$out/lib/netease-cloud-music/plugins" \
      --set QT_QPA_PLATFORM_PLUGIN_PATH "$out/lib/netease-cloud-music/plugins/platforms" \
      --set QCEF_INSTALL_PATH "$out/lib/netease-cloud-music/libs/qcef" \
      --set QT_XKB_CONFIG_ROOT "${xorg.xkeyboardconfig}/share/X11/xkb"
  '';

  meta = {
    description = "Client for Netease Cloud Music service";
    homepage = "https://music.163.com";
    platforms = [ "x86_64-linux" ];
    maintainers = [ stdenv.lib.maintainers.mlatus ];
    license = stdenv.lib.licenses.unfree;
  };
}
