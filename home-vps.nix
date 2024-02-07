{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
  ];

  services.syncthing = {
    enable = true;
    extraOptions = [
      "--gui-address=0.0.0.0:8023"
    ];
  };

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    shellAliases = {
      hms = "home-manager switch --flake ~/.config/home-manager/#vps";
      regen_syncthing_config =
        "syncthing generate --gui-user=kim --gui-password=$SYNCTHING_PASS";
    };

    sessionVariables = {
      SYNCTHING_PASS = "$(pass show syncthing | head -n 1)";
    };

    packages = with pkgs; [
      pass
      nettools
    ];
  };
}
