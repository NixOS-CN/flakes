{ stdenv, fetchFromGitHub, glib, dconf, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "flat-remix-gnome";
  src = fetchFromGitHub {
    owner = "daniruiz";
    repo  = "flat-remix-gnome";
    rev   = "847fd89b9140a1b319ac0f7b662d689d6f0a5b04";
    sha256 = "0x70ql593hv5n7mdp6xan1dz5ns6w13g7ix26ylznvjdiwbjx7j3";
  };
  buildInputs = [ glib.dev dconf ];
  makeFlags = [ "DESTDIR=dist" ];
  postInstall = ''
    mkdir -p $out/share/
    mv dist/usr/share/flat-remix-gnome/themes $out/share/themes
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
