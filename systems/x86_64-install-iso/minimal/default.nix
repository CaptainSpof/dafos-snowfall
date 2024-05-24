{ lib, namespace, ... }:

with lib;
with lib.${namespace};
{
  # `install-iso` adds wireless support that
  # is incompatible with networkmanager.
  networking.wireless.enable = mkForce false;

  dafos = {
    nix = enabled;

    cli-apps = {
      neovim = enabled;
      zellij = enabled;
    };

    tools = {
      git = enabled;
      misc = enabled;
      http = enabled;
      lang = {
        node = enabled;
        nix = enabled;
      };
    };

    hardware = {
      networking = enabled;
    };

    services = {
      openssh = enabled;
    };

    security = {
      doas = disabled;
    };

    system = {
      boot = enabled;
      fonts = enabled;
      locale = enabled;
      time = enabled;
      xkb = enabled;
    };
  };
}
