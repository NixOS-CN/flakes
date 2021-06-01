{ config, lib, ... }:
with lib;
let
  scriptOption = mkOption {
    type = types.lines;
    default = "";
  };
  cfg = config.sops.extendScripts;
in {
  options.sops.extendScripts = {
    pre-sops = scriptOption;
    pre-sops-install-secrets = scriptOption;
    post-sops-install-secrets = scriptOption;
    post-sops = scriptOption;
  };

  config = mkIf (builtins.any (s: s != "") (builtins.attrValues cfg)) {
    system.activationScripts.pre-sops = noDepEntry cfg.pre-sops;
    system.activationScripts.pre-sops-install-secrets =
      stringAfter [ "pre-sops" ] cfg.pre-sops-install-secrets;
    system.activationScripts.setup-secrets.deps =
      [ "pre-sops-install-secrets" ];
    system.activationScripts.post-sops-install-secrets =
      stringAfter [ "setup-secrets" ] cfg.post-sops-install-secrets;
    system.activationScripts.post-sops =
      stringAfter [ "post-sops-install-secrets" ] cfg.post-sops;
  };
}
