{ substituteAll, pkgs, jq }:
let
  path = toString pkgs.path;
  pathWithContext = builtins.appendContext path { "${path}".path = true; };
in
substituteAll {
  dir = "bin";
  isExecutable = true;
  name = "nixos-option";
  pkgPath = pathWithContext;
  jq = "${jq}/bin/jq";
  src = ./nixos-option.sh;
}
