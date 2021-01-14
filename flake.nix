{
  description = "NixOS-cn package collection";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    with nixpkgs.lib;
    with builtins;
    let
      defaultSystem = "x86_64-linux";
      listFiles = dir: map (n: dir + "/${n}") (attrNames (readDir dir));
      listNixFilesRecursive = dir:
        flatten (mapAttrsToList (name: type:
          let path = dir + "/${name}";
          in if type == "directory" then
            if pathExists (dir + "/${name}/default.nix") then
              path
            else
              listNixFilesRecursive path
          else if hasSuffix ".nix" name then
            path
          else
            [ ]) (readDir dir));
      filterBySystem = system: pkgs:
        filterAttrs (_: p:
          if hasAttrByPath [ "meta" "platforms" ] p then
            elem system p.meta.platforms
          else
            system == defaultSystem) pkgs;
      getPackages = f: dir:
        listToAttrs (map (name: {
          inherit name;
          value = f (dir + "/${name}");
        }) (attrNames (readDir dir)));

      makePackageSet = f:
        getPackages f ./top-level // listToAttrs (map (dir: {
          name = baseNameOf dir;
          value = recurseIntoAttrs (getPackages f dir);
        }) (listFiles ./package-set));
      makePackageSet' = system: f: filterBySystem system (makePackageSet f);
      toNixOSCNRegistries = mapAttrs (name: entry: {
        from = {
          id = "nixos-cn";
          ref = name;
          type = "indirect";
        };
        to = entry;
      });

    in eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
      in rec {
        legacyPackages = makePackageSet' system (n: pkgs.callPackage n { });
        checks = flattenTree legacyPackages;
      }) // {
        overlay = final: prev: {
          nixoscn = makePackageSet (n: final.callPackage n { });
        };
        nixosModules.nixoscn = { ... }: {
          nixpkgs.overlays = [ self.overlay ];
          imports = listNixFilesRecursive ./module;
        };
        nixosModules.nixoscn-registries = { ... }: {
          nix.registry = toNixOSCNRegistries (import ./registries.nix);
        };
      };
}
