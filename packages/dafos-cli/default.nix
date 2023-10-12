{ nuenv, ... }:

nuenv.writeScriptBin {
  name = "dafos";
  script = ./dafos-cli.nu;
}
