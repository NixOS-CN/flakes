{ config, lib, options, ... }:
with lib;
let
  scriptOption = mkOption {
    type = types.lines;
    default = "";
  };
  cfg = config.sops.extendScripts;
  hasRegularSecrets =
    (filterAttrs (_: v: !v.neededForUsers) config.sops.secrets) != { };
  hasUserSecrets = (filterAttrs (_: v: v.neededForUsers) config.sops.secrets)
    != { };
in
{
  options.sops.extendScripts = {
    pre-sops = scriptOption;
    pre-sops-install-secrets = scriptOption;
    post-sops-install-secrets = scriptOption;
    post-sops = scriptOption;
  };

  config = optionalAttrs (options ? sops.secrets)
    (mkIf (builtins.any (s: s != "") (builtins.attrValues cfg))
      (mkMerge [
        {
          system.activationScripts.pre-sops = noDepEntry cfg.pre-sops;
          system.activationScripts.pre-sops-install-secrets =
            stringAfter [ "pre-sops" ] cfg.pre-sops-install-secrets;
          system.activationScripts.post-sops-install-secrets = stringAfter
            ((optional hasUserSecrets "setupSecretsForUsers")
              ++ (optional hasRegularSecrets "setupSecrets"))
            cfg.post-sops-install-secrets;
          system.activationScripts.post-sops =
            stringAfter [ "post-sops-install-secrets" ] cfg.post-sops;
        }
        (mkIf hasUserSecrets {
          system.activationScripts.setupSecretsForUsers.deps =
            [ "pre-sops-install-secrets" ];
        })
        (mkIf hasRegularSecrets {
          system.activationScripts.setupSecrets.deps =
            [ "pre-sops-install-secrets" ];
        })
      ]));
}
