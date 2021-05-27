{ config, pkgs, lib, ... }:
with lib;
with builtins;
let
  users = config.users.users;
  substitute = pkgs.writers.writePython3 "substitute" { }
    (replaceStrings [ "@subst@" ] [ "${subst-pairs}" ] (readFile ./subs.py));
  subst-pairs = pkgs.writeText "pairs" (concatMapStringsSep "\n" (name:
    "${config.sops.placeholder.${name}} ${config.sops.secrets.${name}.path}")
    (attrNames config.sops.secrets));
  templateType = types.submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = config._module.args.name;
        description = ''
          Name of the file used in /run/secrets/files
        '';
      };
      path = mkOption {
        type = types.str;
        default = "/run/secrets/files/${config.name}";
      };
      content = mkOption {
        type = types.str;
        default = "";
        description = ''
          Content of the file
        '';
      };
      mode = mkOption {
        type = types.str;
        default = "0400";
        description = ''
          Permissions mode of the in octal.
        '';
      };
      owner = mkOption {
        type = types.str;
        default = "root";
        description = ''
          User of the file.
        '';
      };
      group = mkOption {
        type = types.str;
        default = users.${config.owner}.group;
        description = ''
          Group of the file.
        '';
      };
      file = mkOption {
        type = types.path;
        default = pkgs.writeText config.name config.content;
        visible = false;
        readOnly = true;
      };
    };
  });
in {
  options.sops = {
    templates = mkOption {
      type = types.attrsOf templateType;
      default = { };
    };
    placeholder = mkOption {
      type = types.attrsOf types.str;
      default =
        mapAttrs (name: _: "<SOPS:${hashString "sha256" name}:PLACEHOLDER>")
        config.sops.secrets;
      visible = false;
      readOnly = true;
    };
    substituteCmd = mkOption {
      type = types.path;
      default = substitute;
    };
  };

  config = mkIf (config.sops.templates != { }) {
    system.activationScripts.setup-sops-templates =
      stringAfter [ "setup-secrets" ] ''
        echo setting up sops templates...
        ${concatMapStringsSep "\n" (name:
          let tpl = config.sops.templates.${name};
          in ''
            mkdir -p "${dirOf tpl.path}"
            ${config.sops.substituteCmd} ${tpl.file} > ${tpl.path}
            chmod "${tpl.mode}" "${tpl.path}"
            chown "${tpl.owner}" "${tpl.path}"
            chgrp "${tpl.group}" "${tpl.path}"
          '') (attrNames config.sops.templates)}
      '';
  };
}
