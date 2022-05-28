{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "e760016208a2149fbd444ec9a1aa7418c135545b";
    sha256 = "05v7fw2k7hnbi9m91rshl66d4rg8rxvd14r9ciphw9p7293dsglr";
  };
  dontBuild = true;
  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
