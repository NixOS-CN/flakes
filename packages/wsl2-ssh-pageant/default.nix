{ buildGoModule, fetchFromGitHub }: buildGoModule rec {
  pname = "wsl2-ssh-pageant";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "BlackReloaded";
    repo = "wsl2-ssh-pageant";
    rev = "v${version}";
    sha256 = "sha256-Wnm5SQTYVuc9XwlXwrYaVPGcEAcIOOXmJbE797vwXxA=";
  };

  vendorSha256 = "sha256-YxEoNWbhdkWFTC6k53ZHo0DaRtNUTHhOACi38mpw7+s=";

  buildPhase = ''
    GOOS=windows go build -o wsl2-ssh-pageant.exe main.go
  '';

  installPhase = ''
    mkdir -p ${placeholder "out"}/libexec
    mv wsl2-ssh-pageant.exe ${placeholder "out"}/libexec/.
  '';
}
