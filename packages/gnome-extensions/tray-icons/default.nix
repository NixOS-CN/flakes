{ stdenv, fetchgit, update-nix-fetchgit }:
let uuid = "tray-icons@zhangkaizhao.com";
in stdenv.mkDerivation {
  name = "dynamic-panel-transparent";
  src = fetchgit {
    url = "https://github.com/zhangkaizhao/gnome-shell-extension-tray-icons.git";
    rev = "82a1024bfff0eaa88891c938c0e37cd7857573c8";
    sha256 = "0jsaxcw5hqwc1a98dc17nk4zi5x9bb68bhysaykf5zlv2i1x2x5w";
  };

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp * $out/share/gnome-shell/extensions/${uuid}
  '';
  passthru.updateAction = "${update-nix-fetchgit}/bin/update-nix-fetchgit *";
}
