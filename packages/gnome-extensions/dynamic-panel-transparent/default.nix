{ stdenv, fetchgit, update-nix-fetchgit }:
let uuid = "dynamic-panel-transparency@rockon999.github.io";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/rockon999/dynamic-panel-transparency.git";
    rev = "4ed748a8f048ef4346a7934672bdc59381d1ba43";
    sha256 = "0ymframr2smaw36bgcbg1k3mmc5wzh0xdxzzigj71is29hh7h43h";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
