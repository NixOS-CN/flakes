{ stdenv
, fetchurl
, writeShellScript
, electron
, steam
, scrot
, lib
, makeWrapper
, xdg-utils
, runCommand
}:

################################################################################
# Mostly based on wechat-uos package from AUR:
# https://aur.archlinux.org/packages/wechat-uos
################################################################################

let
  version = "2.1.4";

  license = stdenv.mkDerivation rec {
    pname = "wechat-uos-license";
    version = "0.0.1";
    src = ./license.tar.gz;

    installPhase = ''
      mkdir -p $out
      cp -r etc var $out/
    '';
  };

  resource = stdenv.mkDerivation rec {
    pname = "wechat-uos-resource";
    inherit version;
    src = fetchurl {
      url = "https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.weixin/com.tencent.weixin_${version}_amd64.deb";
      sha256 = "sha256-V74m+dFK9/f0QoHfvIjk7hyIil6FpV9HGkPqwJLvQhM=";
    };

    unpackPhase = ''
      ar x ${src}
    '';

    installPhase = ''
      mkdir -p $out
      tar xf data.tar.xz -C $out
      mv $out/usr/* $out/
      mv $out/opt/apps/com.tencent.weixin/files/weixin/resources/app $out/lib/wechat-uos
      rm -rf $out/opt $out/usr $out/lib/wechat-uos/packages/main/dist/bin
      substituteInPlace $out/lib/wechat-uos/packages/main/dist/index.js \
        --replace '(__dirname,"bin","scrot","scrot")' '("${scrot}/bin","scrot")'
    '';
  };

  pureXDGOpen = lib.hiPrio (runCommand "xdg" { nativeBuildInputs = [ makeWrapper ]; } ''
    mkdir -p $out/bin
    makeWrapper ${xdg-utils}/bin/xdg-open $out/bin/xdg-open \
      --set LD_LIBRARY_PATH "" \
      --set LD_PRELOAD ""
  '');

  steam-run = (steam.override {
    extraPkgs = p: [
      license
      resource
    ] ++ (with p; [
      cups
      libselinux
      libgpgerror
      scrot
      pureXDGOpen
    ]);
    runtimeOnly = true;
  }).run;

  startScript = writeShellScript "wechat-uos" ''
    wechat_pid=`pidof wechat-uos`
    if test  $wechat_pid ;then
      kill -9 $wechat_pid
    fi
    ${steam-run}/bin/steam-run \
      ${electron}/bin/electron \
      ${resource}/lib/wechat-uos
  '';
in
stdenv.mkDerivation {
  pname = "wechat-uos";
  inherit version;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin $out/share/applications
    ln -s ${startScript} $out/bin/wechat-uos
    ln -s ${./wechat-uos.desktop} $out/share/applications/wechat-uos.desktop
    ln -s ${resource}/share/icons $out/share/icons
  '';

  meta = with lib; {
    description = "微信官方原生桌面版 WeChat desktop";
    homepage = "https://weixin.qq.com/";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfreeRedistributable;
  };
}
