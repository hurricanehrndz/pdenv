{
  python3,
  yamllint-src,
  ...
}:
python3.pkgs.buildPythonApplication rec {
  name = "yamllint";
  src = yamllint-src;
  doCheck = false;
  propagatedBuildInputs = with python3.pkgs; [setuptools pyaml pathspec];
}
