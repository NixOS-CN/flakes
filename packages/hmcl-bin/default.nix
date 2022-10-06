{ lib
, stdenv
, file
, glib
, fetchurl
, makeWrapper
, wrapGAppsHook
, jdk
, alsa-lib
, xorg
, wayland
, libpulseaudio
, libglvnd
, libGL
, dconf
, glfw
, makeDesktopItem
, copyDesktopItems
, type ? "jar"
, sourceProvenance ? (if type == "jar" then [ lib.sourceTypes.binaryBytecode ] else [])
, openal }:

stdenv.mkDerivation rec {
  name = "hmcl-bin";
  version = "3.5.3.223";

  src = fetchurl {
    url = "https://github.com/huanghongxun/HMCL/releases/download/v${version}/HMCL-${version}.jar";
    sha256 = "sha256-8g2FMvAiAKfxJUY0G7wl6d44wOpVsknFHGZ85IkOzFc=";
  };

  dontUnpack = true;

  icon = fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/craft_table.png?h=hmcl-bin";
    sha256 = "sha256-KYmhtTAbjHua/a5Wlsak5SRq+i1PHz09rVwZLwNqm0w";
  };

  buildInputs = [ (lib.getLib dconf) glib ];
  nativeBuildInputs = [ jdk wrapGAppsHook makeWrapper file copyDesktopItems ];

  installPhase = let
    libpath = with xorg; lib.makeLibraryPath ([
      libGL
      glfw
      openal
      libglvnd
    ] ++ lib.lists.optionals stdenv.isLinux [
      libX11
      libXext
      libXcursor
      libXrandr
      libXxf86vm
      libpulseaudio
      wayland
    ]);
  in ''
    runHook preInstall
    mkdir -p $out/{bin,lib/hmcl-bin}
    cp $src $out/lib/hmcl-bin/hmcl-bin.jar
    install -Dm644 $icon $out/share/icons/hicolor/48x48/apps/hmcl.png
    makeWrapper  ${jdk}/bin/java $out/bin/hmcl-bin \
      --add-flags "-jar $out/lib/hmcl-bin/hmcl-bin.jar" \
      --set LD_LIBRARY_PATH ${libpath}
    runHook postInstall
  '';

  desktopItems = lib.toList (makeDesktopItem {
    name = "HMCL (bin)";
    exec = "hmcl-bin";
    icon = "hmcl";
    comment = "A Minecraft Launcher which is multi-functional, cross-platform and popular";
    desktopName = "HMCL (bin)";
    categories = [ "Game" ];
  });


  meta = with lib; {
    homepage = "https://hmcl.huangyuhui.net/";
    description = "A Minecraft Launcher which is multi-functional, cross-platform and popular";
    longDescription = ''
      HMCL is a cross-platform Minecraft launcher which supports Mod Management, Game Customizing, Auto Installing (Forge, Fabric, Quilt, LiteLoader and OptiFine), Modpack Creating, UI Customization, and more.
    '';
    license = licenses.gpl3Plus;
    sourceProvenance = sourceProvenance;
    maintainers = with maintainers; [ yisuidenghua ];
  };
}
