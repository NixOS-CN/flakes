{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "f8c2af234a9a40e1936080c8d1198232bb75d00d";
    sha256 = "036byqa5gc1rih4g015v91y6x4zvkbyq7l2m8ybaavm431g7mxzs";
  };
  dontBuild = true;
  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
