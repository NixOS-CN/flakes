{ stdenv, fetchgit, update-nix-fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "4f55d5dcd15610abd4a025b34f12a2b5b04db911";
    sha256 = "0lcj930xg1q1hlav3xxa4sjck5xi1a4l5f5aicrxpfm65k72h35r";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
    cp -r * $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
  '';
  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
