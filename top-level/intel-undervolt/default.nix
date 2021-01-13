{ stdenv, fetchFromGitHub, pkgconfig, coreutils }:
let outDir = placeholder "out";
in stdenv.mkDerivation rec {
  name = "intel-undervolt";
  src = fetchFromGitHub {
    owner = "kitsunyan";
    repo = "intel-undervolt";
    rev = "ea0e74c583fb0ba4bccd896d3e9c7eb83507b749";
    sha256 = "1fjhjqxhcgzawqmknxhmrkq0b7hjfpw6fcigzyw6vg5yf2lws507";
  };
  nativeBuildInputs = [ pkgconfig ];
  configureFlags = [
    "--bindir=${outDir}/bin"
    "--sysconfdir=/etc"
    "--unitdir=${outDir}/lib/systemd/system"
    "--enable-systemd"
  ];
  preConfigure = ''
    substituteInPlace Makefile.in --replace '$(DESTDIR)$(SYSCONFDIR)' "${outDir}/etc"
    substituteInPlace intel-undervolt-loop.service.in --replace '/bin/kill' "${coreutils}/bin/kill"
  '';
}
