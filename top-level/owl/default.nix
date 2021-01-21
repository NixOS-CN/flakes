{ stdenv, cmake, libpcap, libev, libnl, fetchFromGitHub }: stdenv.mkDerivation rec {
  name = "owl";

  src = fetchFromGitHub {
    owner = "seemoo-lab";
    repo  = "owl";
    rev   = "fb09463f6a3d175c125165b89ec39a25b33e14b1";
    sha256 = "1w026cw8fcws1bi5hwnv654zzgdgb05vdv63zj0jrx59kb304b21";
    fetchSubmodules = true;
  };

  buildInputs = [ cmake libpcap libev libnl ];

  meta.description = "An open Apple Wireless Direct Link (AWDL) implementation written in C";
}
