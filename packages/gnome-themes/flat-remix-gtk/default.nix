{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "ec05fde89316c1d5d6640eb25045a246482e91c6";
    sha256 = "1y0h0w1niy9lbkrhm4cbr00x6vcw45wfdx95sbapipiiy2chhqxg";
  };
  dontBuild = true;
  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
