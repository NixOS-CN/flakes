{ stdenv, fetchgit, jq }:
let uuid = "tray-icons@zhangkaizhao.com";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/zhangkaizhao/gnome-shell-extension-tray-icons.git";
    rev = "bde2b275f7afe4b4b252836ad73fd31b8aa5a9ac";
    sha256 = "06wdyzikzbbij77id0zg6nxxjaddn9af9h2sjfbqh3kjz4nwj2z6";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp * $out/share/gnome-shell/extensions/${uuid}
  '';
}
