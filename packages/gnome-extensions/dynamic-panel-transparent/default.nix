{ stdenv, fetchgit, jq, update-nix-fetchgit }:
let uuid = "dynamic-panel-transparency@rockon999.github.io";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/rockon999/dynamic-panel-transparency.git";
    rev = "63c8b81d5544cc1e6d2ee9fd236b705a531b641b";
    sha256 = "1znb6h43cgbq5162spsx5prjzbckykr7g1afrfkh5j66zw6lv79a";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
