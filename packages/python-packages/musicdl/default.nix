{ python3, writeScript, writeText, fetchurl }: with python3.pkgs;
let
  script_patch = fetchurl {
    url = "https://github.com/CharlesPikachu/musicdl/pull/12.patch";
    sha256 = "0yya15aqka0hxnmzkfmhm7zycgsc890rjcsmw276428753qmw8al";
  };
  defaultConfig = writeText "config.json" (builtins.toJSON {
    logfilepath = "musicdl.log";
    proxies = {};
    search_size_per_source = 5;
    savedir = "downloaded";
  });
  runMusicdl = writeScript "musicdl" ''
    #!/usr/bin/env python
    from musicdl.musicdl import run_main
    run_main()
  '';
in
buildPythonApplication rec {
  pname = "musicdl";
  version = "2.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1c1rcxzr34xs4j5l4x1f4rxcwq9nwg8cmxvlk35q1z81yhdw64k8";
  };

  doCheck = false;

  patches = [ script_patch ];
  postInstall = ''
    install -D ${runMusicdl} $out/bin/musicdl
    install -D ${defaultConfig} $out/share/musicdl/config.json
  '';

  propagatedBuildInputs = [ pycryptodome requests click prettytable ];
}
