{
  pkgs,
  lib,
  namespace,
  ...
}:

let
  inherit (lib) mkForce;
  inherit (lib.${namespace})
    guide
    guideHTML
    enabled
    disabled
    ;

in
{
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    cryptsetup
    gnupg
    pinentry-curses
    pinentry-qt
    paperkey
    wget
    firefox
  ];

  programs = {
    ssh.startAgent = false;
  };

  dafos = {
    nix = enabled;

    desktop = {
      gnome = {
        enable = true;
      };
    };

    apps = {
      firefox = enabled;
    };

    tools = {
      misc = enabled;
      git = enabled;
    };

    home.file."guide.md".source = guide;
    home.file."guide.html".source = guideHTML;

    security = {
      doas = disabled;
    };

    system = {
      fonts = enabled;
      locale = enabled;
      networking = {
        # Networking is explicitly disabled in this environment.
        enable = mkForce false;
      };
      time = enabled;
      xkb = enabled;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
