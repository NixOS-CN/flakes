{ python3 }: with python3.pkgs;
buildPythonPackage rec {
  pname = "YubiOTP";
  version = "1.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Ohs/o63hlvtiqMZxbf4O5nmsegZhZiW0ic9gOdqhfwg=";
  };

  buildInputs = [ pycryptodome ];
  propagatedBuildInputs = [ six pycrypto ];
}
