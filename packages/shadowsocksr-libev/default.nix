{ gcc7Stdenv, fetchgit, libsodium, libev, pcre, asciidoc, xmlto, docbook_xml_dtd_45
, docbook_xsl, zlib, openssl, udns, autoconf, automake, libtool, patchelf }:
gcc7Stdenv.mkDerivation {
  name = "shadowsocksr-libev";
  src = fetchgit {
    url = "https://github.com/shadowsocksrr/shadowsocksr-libev.git";
    rev = "4799b312b8244ec067b8ae9ba4b85c877858976c";
    sha256 = "19mk90f7d1g7i3wdls3l9fvgjl4maqg9w5g35i5w28irgbckwbgm";
  };

  buildInputs = [ libsodium libev pcre openssl udns ];
  nativeBuildInputs = [
    autoconf
    automake
    libtool
    asciidoc
    xmlto
    docbook_xsl
    docbook_xml_dtd_45
    zlib
    patchelf
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  preFixup = ''
    for executable in $out/bin/ss-local $out/bin/ss-redir; do
      patchelf --set-rpath $out/lib:$(patchelf --print-rpath "$executable") "$executable"
    done
  '';

  dontStrip = true;

  meta.description = "Shadowsocksr-libev is a lightweight secured SOCKS5 proxy for embedded devices and low-end boxes";
}
