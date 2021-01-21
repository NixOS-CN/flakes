{ pkgs, lib, applyPatches, stdenv, runCommand, makeWrapper, fetchFromGitHub
, nodejs, hostInLocalNet ? true, infiniteAnimation ? true }:
let
  source = applyPatches {
    src = fetchFromGitHub {
      owner = "RobinLinus";
      repo = "snapdrop";
      rev = "07244871328f7b90593086de642f94df91e4a0d8";
      sha256 = "sha256-oMO6X6ICh3urSFpgpgS4x5olM+RHGqPyyiC0hHnDJuY=";
    };
    patches = with lib;
      optional hostInLocalNet ./one-room.patch
      ++ optional infiniteAnimation ./infinite-animation.patch;
  };
  server = (import ./server.nix { inherit pkgs source; }).package;
in runCommand "snapdrop" {
  nativeBuildInputs = [ makeWrapper ];
  meta.description = "A Progressive Web App for local file sharing";
} ''
  mkdir -p $out/bin
  makeWrapper ${nodejs}/bin/node $out/bin/snapdrop --add-flags ${server}/lib/node_modules/snapdrop/index.js
  mkdir -p $out/lib/share/snapdrop
  cp -R ${source}/client $out/lib/share/snapdrop/client
''
