{ stdenv, fetchgit, jq, update-nix-fetchgit }:
let uuid = "dynamic-panel-transparency@rockon999.github.io";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/rockon999/dynamic-panel-transparency.git";
    rev = "f9e720e98e40c7a2d87928d09a7313c9ef2e832c";
    sha256 = "0njykxjiwlcmk0q8bsgqaznsryaw43fspfs6rzsjjz5p0xaq04nw";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions
  '';
  updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
