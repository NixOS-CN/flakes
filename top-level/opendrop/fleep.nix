{ buildPythonPackage, fetchPypi }: buildPythonPackage rec {
  pname = "fleep";
  version = "1.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-yPYrJY7lNk1/bB7R8/J46ZAg/D8KYKJK0eEIRuMdEEw=";
  };
}
