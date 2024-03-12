{ lib, config, pkgs, ... }:
{
  imports = [
    ../../common.nix
  ];

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    shellAliases = {
      hms = "home-manager switch --flake ~/.config/home-manager/#vps";
    };

    packages = with pkgs; [
      pass

      hugo
      nginx
    ];
  };
}
