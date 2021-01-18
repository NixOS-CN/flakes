{ stdenv, qtbase, cmake, fetchFromGitHub }: stdenv.mkDerivation {
  pname = "qhttpengine";
  version = "2018-03-22";

  src = fetchFromGitHub {
    owner = "nitroshare";
    repo = "qhttpengine";
    rev = "43f55df51623621ed3efb4e42c7894586d988667";
    sha256 = "10r3ybcgm6602iadnxr502bfdld03srh4sgclyhq6l5j886pmvjw";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ qtbase ];
}
