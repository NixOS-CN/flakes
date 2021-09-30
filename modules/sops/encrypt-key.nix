{ config, lib, pkgs, options, ... }:
with lib;
let
  dir = "/run/sops-keys";
  getPath = f: "${dir}/${builtins.hashString "sha256" f}";
  keyFiles = config.sops.encryptedSSHKeyPaths;
  script = pkgs.writeShellScript "decrypt" ''
    mkdir -p "${dir}"
    ${concatMapStringsSep "\n" (keyFile:
      let keyPath = getPath keyFile;
      in ''
        cp "${keyFile}" "${keyPath}"
        while true;do
          echo -n 'Enter passphrase for ${keyFile}:'
          read -s sops_pass
          echo
          ${pkgs.openssh}/bin/ssh-keygen -p -P "$sops_pass" -N "" -f "${keyPath}" 2> /dev/null
          sops_decrypt_result=$?
          unset sops_pass
          if [[ $sops_decrypt_result -ne 0 ]];then
            sleep 3
            echo -n 'Failed to decrypt ${keyFile}, what to do now (continue anyway[c], enter passphrase again[r], defaults to [r]):'
            read sops_choice
            echo
            if [[ "$sops_choice" == "c" ]];then
              break
            fi
          else
            break
          fi
        done
      '') keyFiles}
      exit 0
  '';
in {
  options.sops.encryptedSSHKeyPaths = mkOption {
    type = types.listOf types.path;
    default = [ ];
  };

  config = optionalAttrs (options ? sops.gnupg.sshKeyPaths) (mkIf (keyFiles != [ ]) {
    sops.gnupg.sshKeyPaths = map getPath keyFiles;
    sops.extendScripts.pre-sops-install-secrets = ''
      echo Decrypting sops keys...
      ${script}
    '';
    sops.extendScripts.post-sops = ''
        echo Erasing decrypted sops keys...
        rm -rf "${dir}"
      '';
  });
}
