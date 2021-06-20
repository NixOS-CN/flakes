# 简介

这里是由 NixOS 中文社区维护的一个 [Nix Flakes](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html) , 包括社区成员贡献的一些包以及 NixOS 模块.

目前社区成员主要在 [Telegram 群组](https://github.com/nixos-cn/NixOS-CN-telegram) 进行交流.

# 使用

```nix
# cat flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  # 引入 nixos-cn flake 作为 inputs
  inputs.nixos-cn = {
    url = "github:nixos-cn/flakes";
    # 强制 nixos-cn 和该 flake 使用相同版本的 nixpkgs
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-cn }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ ... }: {
            # 使用 nixos-cn flake 提供的包
            environment.systemPackages =
              [ nixos-cn.legacyPackages.${system}.netease-cloud-music ];
            # 使用 nixos-cn 的 binary cache
            nix.binaryCaches = [
              "https://nixos-cn.cachix.org"
            ];
            nix.binaryCachePublicKeys = [ "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg=" ];

            imports = [
              # 将nixos-cn flake提供的registry添加到全局registry列表中
              # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
              nixos-cn.nixosModules.nixos-cn-registries

              # 引入nixos-cn flake提供的NixOS模块
              nixos-cn.nixosModules.nixos-cn
            ];
          })
        ];
      };
    };
}
```

# 贡献指南

## 贡献新的包

例如你希望向 nixos-cn flake 提供 `opendrop` 这个包:

```sh
$ git clone https://github.com/nixos-cn/flakes
$ cd flakes/packages
$ mkdir opendrop
$ cd opendrop
$ $EDITOR default.nix
```

`packages` 下的所有 `.nix` 文件或者包含 `default.nix` 的文件夹都会被递归地 `callPackage` 写入 `legacyPackages.${system}.${directory-name}`, 即 `github:nixos-cn/flakes#legacyPackages.opendrop = callPackage ./packages/opendrop`, 并且 `github:nixos-cn/flakes#legacyPackages.gnome-extension.compiz-windows-effect = callPackage ./packages/gnome-extension/compiz-windows-effect`.

## 贡献新的 NixOS 模块

直接往 `module` 文件夹中添加任意 `.nix` 文件. `module` 文件夹下的所有 `.nix` 文件或者包含 `default.nix` 的文件夹都会被递归地 import 到 `nixosModules.nixos-cn` 中.

假设目前`module`文件夹的结构如下:

```
module
├── module-1.nix
├── module-2
│   ├── default.nix
│   ├── helper.nix
│   └── config
│       └── default.nix
└── module-set
    ├── module-1.nix
    └── module—2.nix
```

则 `nixosModules.nixos-cn` 中将包含:
```nix
{ ... }: {
  imports = [
    ./module/module-1.nix
    ./module-2
    ./module-set/module-1.nix
    ./module-set/module-2.nix
  ];
}
```

## 贡献新的 Registry entries

如果你不希望将你的包直接加入到 nixos-cn, 也可以选择提供你的 flakes url 作为 registry entry, 可参考 `registries.nix` 中已有的 registry entries.

`registries.nix` 中的 entry 会被添加到 `nixosModules.nixos-cn-registries` 所提供的 registry 列表中, 并且每个 flake 提供的 `packages` 都会被放入 `legacyPackages.re-export`.
即 `github:nixos-cn/flakes#legacyPackages.re-export = fold (r: s: s // r.packages) {} (getFlakes ./registries.nix)`.
