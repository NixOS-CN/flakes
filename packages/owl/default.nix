{ stdenv, cmake, libpcap, libev, libnl, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation rec {
  name = "owl";

  src = fetchFromGitHub {
    owner = "seemoo-lab";
    repo = "owl";
    rev = "8e4e840b212ae5a09a8a99484be3ab18bad22fa7";
    sha256 = "1y6x8miz1irx3xg4mmhz9svvl5h7gymdxiskwip60n66a8j3wnch";
    fetchSubmodules = true;
  };

  buildInputs = [ cmake libpcap libev libnl ];

  meta.description =
    "An open Apple Wireless Direct Link (AWDL) implementation written in C";
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
