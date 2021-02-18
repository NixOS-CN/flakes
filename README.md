# 简介

这里是由NixOS中文社区维护的一个[Nix Flakes](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html), 包括社区成员贡献的一些包以及NixOS模块.

目前社区成员主要在[Telegram频道](https://github.com/nixos-cn/NixOS-CN-telegram)进行交流.

# 使用

```nix
# cat flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  # 引入nixos-cn flake作为inputs
  inputs.nixos-cn = {
    url = "github:nixos-cn/flakes";
    # 强制nixos-cn和该flake使用相同版本的nixpkgs
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-cn }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ ... }: {
            # 使用nixos-cn flake提供的包
            environment.systemPackages =
              [ nixos-cn.legacyPackages.${system}.netease-cloud-music ];

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

例如你希望向nixos-cn flake提供`opendrop`这个包:

```sh
$ git clone https://github.com/nixos-cn/flakes
$ cd flakes/top-level
$ mkdir opendrop
$ cd opendrop
$ $EDITOR default.nix
```

`top-level`下的各个文件夹会自动被`callPackage`写入`legacyPackages.${system}.${directory-name}`, 即`github:nixos-cn/flakes#legacyPackages.opendrop = callPackage ./top-level/opendrop`.

如果你认为你希望贡献的包不应该放进top-level (例如一个Gnome扩展), 可以将其放到`package-set`下.
以Gnome扩展`compiz-windows-effect`为例:

```sh
$ cd flakes/package-set
$ mkdir -p gnome-extension/compiz-windows-effect
$ cd gnome-extension/compiz-windows-effect
$ $EDITOR default.nix
```

此时有`github:nixos-cn/flakes#legacyPackages.gnome-extension.compiz-windows-effect = callPackage ./package-set/gnome-extension/compiz-windows-effect`.

## 贡献新的NixOS模块

直接往`module`文件夹中添加任意`.nix`文件. `module`文件夹下的所有`.nix`文件或者包含`default.nix`的文件夹都会被递归地import到`nixosModules.nixos-cn`中.

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

则`nixosModules.nixos-cn`中将包含:
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

## 贡献新的Registry

如果你不希望将你的包直接加入到nixos-cn, 也可以选择提供你的flakes url作为registry, 可参考`registries.nix`中已有的registry.

`registries.nix`中的entry会被添加到`nixosModules.nixos-cn-registries`所提供的registry列表中, 并且每个flake提供的`packages`和`legacyPackages`都会被放入`legacyPackages.re-export`.
即`github:nixos-cn/flakes#legacyPackages.re-export = fold (r: s: s // r.packages // r.legacyPackages) {} (getFlakes ./registries.nix)`.
