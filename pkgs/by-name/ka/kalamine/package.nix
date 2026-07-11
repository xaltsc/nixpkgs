{
  lib,
  python3Packages,
  fetchFromGitHub,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "kalamine";
  version = "0.40";
  pyproject = true;

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "OneDeadKey";
    repo = "kalamine";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9R8N5p+VNuiqTl3a0SSmJEVg3Ol76nROf43GsdOdJL8=";
  };

  build-system = [
    python3Packages.hatchling
  ];

  dependencies = with python3Packages; [
    click
    livereload
    lxml
    progress
    pyyaml
    tomli
  ];

  pythonImportsCheck = [ "kalamine" ];

  disabledTestPaths = [
    "tests/test_macos.py" # requires a file not included in the src tree
  ];

  nativeCheckInputs = [
    python3Packages.pytestCheckHook
    versionCheckHook
    writableTmpDirAsHomeHook
  ];
  versionCheckProgramArg = "version";
  versionCheckKeepEnvironment = [ "HOME" ];

  meta = {
    description = "Keyboard Layout Maker";
    homepage = "https://github.com/OneDeadKey/kalamine/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ xaltsc ];
    mainProgram = "kalamine";
  };
})
