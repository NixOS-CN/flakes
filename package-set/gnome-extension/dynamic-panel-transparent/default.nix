{ stdenv, fetchgit, jq }:
let uuid = "dynamic-panel-transparency@rockon999.github.io";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/rockon999/dynamic-panel-transparency.git";
    rev = "0800c0a921bb25f51f6a5ca2e6981b1669a69aec";
    sha256 = "0200mx861mlsi9lf7h108yam02jfqqw55r521chkgmk4fy6z99pq";
  };

  buildPhase = ''
    meta=`mktemp`
    cat ${uuid}/metadata.json | ${jq}/bin/jq '."shell-version" += [ "3.36" ]' > $meta
    cat $meta > ${uuid}/metadata.json
  '';

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions
  '';
}
