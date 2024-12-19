{
  lib,
  fetchFromGitHub,
  buildHomeAssistantComponent,
  python312Packages,
}:

buildHomeAssistantComponent {
  owner = "d03n3rfr1tz3";
  domain = "hass-divoom";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "d03n3rfr1tz3";
    repo = "hass-divoom";
    rev = "7a49f32c833aaa852f02d22bc7faf0277a5f5639";
    hash = "sha256-AFdICIbwLIB9tvEeaRYt8dzll54fWToZVuhYHwJPUws=";
  };

  makeWrapperArgs = [ "--prefix PATH : ${lib.makeBinPath [ python312Packages.btsocket ]}" ];

  #skip phases with nothing to do
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  meta = with lib; {
    changelog = "";
    description = "";
    homepage = "";
    license = licenses.mit;
  };
}
