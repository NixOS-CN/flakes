{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "e9cf83e3609f128ad7dda9962e9ccdd9e4b6b2f5";
    sha256 = "1j5iji8aid4qhvibi6q0pshalwdrdn0zi8hyw4g5qxqaw6q2dnhg";
  };
  dontBuild = true;
  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
