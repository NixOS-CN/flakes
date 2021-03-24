{ stdenv, fetchgit }:
stdenv.mkDerivation {
  name = "gnome-shell-extension-x11gestures";
  src = fetchgit {
    url = "https://github.com/JoseExposito/gnome-shell-extension-x11gestures.git";
    rev = "60e112601932279128490a47493b7fa8aed876e3";
    sha256 = "033axk2fzn7kcf4qs7s95bnrppxcbivrjzmrxgglv2h2v3ik6jz0";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
    cp -r * $out/share/gnome-shell/extensions/x11gestures@joseexposito.github.io
  '';
}
