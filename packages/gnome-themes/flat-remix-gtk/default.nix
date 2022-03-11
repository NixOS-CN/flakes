{ stdenv, fetchFromGitHub, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gtk";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gtk";
    rev   = "9933daf091dde9cff695d485ee06a670f2f169b6";
    sha256 = "06j390381rk2z67s47i5j07yi3flybm4wlxq6diqllpmcqq2mabw";
  };
  dontBuild = true;
  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
