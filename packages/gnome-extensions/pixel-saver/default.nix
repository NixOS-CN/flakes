{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "pixel-saver";
  src = fetchgit {
    url = "https://github.com/pixel-saver/pixel-saver";
    rev = "a7adee78f0df16ef9e824a22be5e0a0528d7d803";
    sha256 = "1nq9cdv5gvq2mqrynzw3q0mwj3km6pi4qk6kix4kry86frbr8cwm";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r pixel-saver@deadalnix.me $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
