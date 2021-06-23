{ stdenv, fetchFromGitHub, glib, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "90b1c5c23d66f036727477e553d2d97749cc8f0f";
    sha256 = "16jvs1cgd8n7igz5k497l8k644zzwg6xi3f10yyi43v31zjj4m39";
  };
  buildInputs = [ glib.dev ];
  installPhase = ''
    mkdir -p $out/share/themes
    cp -r Flat-Remix-* $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
