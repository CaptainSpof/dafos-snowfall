{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.home;
in
{
  # imports = with inputs; [
  #   home-manager.nixosModules.home-manager
  # ];

  options.dafos.home = with types; {
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    dafos.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.dafos.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.dafos.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.dafos.user.name} =
        mkAliasDefinitions options.dafos.home.extraOptions;
    };
  };
}
