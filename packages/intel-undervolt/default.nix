{ stdenv, fetchFromGitHub, pkg-config, coreutils, update-nix-fetchgit }:
let outDir = placeholder "out";
in stdenv.mkDerivation rec {
  name = "intel-undervolt";
  src = fetchFromGitHub {
    owner = "kitsunyan";
    repo = "intel-undervolt";
    rev = "ea0e74c583fb0ba4bccd896d3e9c7eb83507b749";
    sha256 = "1fjhjqxhcgzawqmknxhmrkq0b7hjfpw6fcigzyw6vg5yf2lws507";
  };
  nativeBuildInputs = [ pkg-config ];
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

  meta.description = "Intel CPU undervolting and throttling configuration tool";
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
