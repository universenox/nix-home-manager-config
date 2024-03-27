{ lib, config, pkgs, ... }:
{
  imports = [
    ../../common.nix
  ];

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    packages = with pkgs; [
      pass

      hugo
      nginx
    ];
  };
}
