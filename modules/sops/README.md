一些对 [sops-nix](https://github.com/Mic92/sops-nix) 的扩展, 依赖 `sops` 模块.

## sops.templates.\<name\>
当你需要使用 sops 加密某个文件的一部分的时候会比较有用.

### 用例
假设在配置中已经定义了如下的 secrets:
```nix
{ ... }: {
  sops.secrets.v2ray-user = {};
  sops.secrets.v2ray-pass = {};
}
```

就可以使用如下配置:
```nix
{ ... }: {
  services.v2ray = {
    enable = true;
    configFile = config.sops.templates.v2ray.path; # 开机解密后的文件路径
  };

  # 定义文件内容, 开机后这部分内容会被拷贝到 `config.sops.templates.v2ray.path`
  sops.templates.v2ray.content = builtins.toJSON {
    inbounds = [{
      port = 1080;
      listen = "127.0.0.1";
      protocol = "http";
      settings = {
        accounts = [{
          # 文件 `config.sops.templates.v2ray.path` 中
          # `config.sops.placeholder.v2ray-user` 对应部分的内容
          # 会被替换为 `config.sops.secrets.v2ray-user.path` 中的内容,
          # 以此类推
          user = config.sops.placeholder.v2ray-user;
          pass = config.sops.placeholder.v2ray-pass;
        }];
      };
    }];
    outbounds = [{
      protocol = "freedom";
    }];
  };
}
```

## sops.encryptedSSHKeyPaths
允许使用 passphrase 加密后的 SSH Key 作为 sops-nix 解密时使用的 keyfile.

### 用例
使用 `sops.encryptedSSHKeyPaths` 代替 `sops.sshKeyPaths` 即可.

```nix
{ ... }: {
  # sops.sshKeyPaths = [ "/var/lib/sops.key" ];
  sops.encryptedSSHKeyPaths = [ "/var/lib/sops.key" ];
}
```

开机时会多一步输入 passphrase 的过程.
