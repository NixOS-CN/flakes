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
        filterAttrsRecursive (_: p:
          !(isDerivation p) || (if hasAttrByPath [ "meta" "platforms" ] p then
            elem system p.meta.platforms
          else
            system == defaultSystem)) pkgs;
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

      toNixOSCNRegistries = mapAttrs (name: entry: {
        from = {
          id = "nixos-cn";
          ref = name;
          type = "indirect";
        };
        to = entry;
      });
      # Currently we only have github/gitlab registries
      registryEntryToGitURL = entry:
        with entry;
        "https://${type}.com/${owner}/${repo}.git";
      registryEntryToFlakeURL = entry: lock:
        with entry;
        "${type}:${owner}/${repo}/${lock.rev}";
      registryOutputs = let
        locks = importJSON ./registries.lock;
        registries = import ./registries.nix;
      in mapAttrs (name: entry:
        (getFlake (registryEntryToFlakeURL entry locks.${name})).outputs)
      registries;
      extractFromRegistries = f:
        filterAttrs (_: v: v != { }) (mapAttrs f registryOutputs);
      mapRecurseIntoAttrs = s:
        mapAttrs (_: v:
          if !isAttrs v || isDerivation v then v else mapRecurseIntoAttrs v)
        (recurseIntoAttrs s);

    in eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
      in rec {
        legacyPackages = filterBySystem system (makePackageSet (n: pkgs.callPackage n { }) // {
          re-export = mapRecurseIntoAttrs (extractFromRegistries (_: output:
            (attrByPath [ "packages" system ] { } output)
            // (attrByPath [ "legacyPackages" system ] { } output)));
        });
        checks = flattenTree legacyPackages;
        apps = {
          update-lock = mkApp {
            drv = with pkgs;
              writeShellScriptBin "update-lock" ''
                export PATH=${makeBinPath [ git coreutils jq ]}
                function getRev(){
                  git ls-remote $1 HEAD|cut -f1
                }
                lock='{}'
                ${concatStrings (mapAttrsToList (name: entry: ''
                  lock=$(echo "$lock"|jq -c ".\"${name}\".rev = \"$(getRev "${
                    registryEntryToGitURL entry
                  }")\"")
                '') (import ./registries.nix))}
                echo "$lock"|jq
              '';
          };
        };
      }) // {
        overlay = final: prev: {
          nixoscn = recurseIntoAttrs (makePackageSet (n: final.callPackage n { }));
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
