self: super:
with builtins;
with self.lib;
let
  mapRecurseIntoAttrs' = key: s:
    if any (k: k == key) (attrNames s) then
      s
    else
      mapAttrs (k: v:
        if !isAttrs v || isDerivation v then
          v
        else
          mapRecurseIntoAttrs' k v) (recurseIntoAttrs s);
  mapRecurseIntoAttrs = mapRecurseIntoAttrs' null;
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
  getPackages = f: dir:
    let
      getAttrPathPrefix = target:
        filter (p: p != "") (splitString "/"
          (removePrefix (toString dir) (toString (dirOf target))));
      getName = target:
        let baseName = baseNameOf target;
        in if hasSuffix ".nix" baseName then
          removeSuffix ".nix" baseName
        else
          baseName;
      getAttrPath = target:
        ((getAttrPathPrefix target) ++ [ (getName target) ]);
    in foldl (set: target:
      recursiveUpdate set (setAttrByPath (getAttrPath target) (f target)))
    { } (listNixFilesRecursive dir);
  makePackageSet = f: getPackages f ./packages;
  makePackageScope = pkgs:
    makeScope pkgs.newScope (self:
      (makePackageSet
        (n: self.callPackage n { } // { __definition_entry = n; })));
in
{
  nixos-cn = mapRecurseIntoAttrs (makePackageScope self);
}
