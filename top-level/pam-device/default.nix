{ stdenv, fetchFromGitHub, substituteAll, gnome3, wrapGAppsHook, python3, bluez
, usbutils, gobject-introspection, gdk-pixbuf }:
let pythonInUse = python3.withPackages (p: with p; [ pygobject3 ]);
in stdenv.mkDerivation rec {
  name = "pam-device";
  src = fetchFromGitHub {
    owner = "Ninlives";
    repo = "pam-device";
    rev = "d7756d455e8d56bb77f98d5af59c49ca6852453c";
    sha256 = "09qnrpwxdwf9wj2y99qr2qrwf5s1mmyq46l6bkilci6758513520";
  };

  patches = [ ./fix-path.patch ];

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = [ pythonInUse gobject-introspection gnome3.gtk3 gdk-pixbuf ];

  outpath = "${placeholder "out"}";
  bluetoothctl = "${bluez}/bin/bluetoothctl";
  lsusb = "${usbutils}/bin/lsusb";
  installPhase = ''
    mkdir -p $out;
    cp -r bin $out/bin

    mkdir -p $out/share/pam-device
    mkdir -p $out/share/applications
    cp -r data/icons $out/share
    cp -r data/pam-device.desktop $out/share/applications
    cp -r src/pamdevicegui $out/share/pam-device
    cp -r debian/changelog $out/share/pam-device

    mkdir -p $out/lib/security
    cp -r src/pam_device.py $out/lib/security
    cp -r src/pamdevice $out/lib/security

    for f in $(find $out -type f);do
      substituteAllInPlace $f
      substituteInPlace $f \
        --replace '/usr/bin/env python3' \
                  '${pythonInUse}/bin/python3'
    done
  '';

  meta.description = "PAM DEVICE is a Pluggable Authentication Module for device authentication";
}
