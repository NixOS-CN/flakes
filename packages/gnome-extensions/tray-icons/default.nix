{ stdenv, fetchgit, jq }:
let uuid = "tray-icons@zhangkaizhao.com";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/zhangkaizhao/gnome-shell-extension-tray-icons.git";
    rev = "22b74b9a602560bf71ffbb6959b161afeeebe2ff";
    sha256 = "0c5jpf5d1yzfwv6b0yam3hg980hfw0rck3r70y2hshvncmvk30w0";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp * $out/share/gnome-shell/extensions/${uuid}
  '';
}
