# home.nix but for work
# some notes:
# - kitty doesn't work bc openGL driver is too old :(
# - http(s)_proxy variables?
# 
{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
    ./common.nix
  ];

  home = {
    username = "kswanson";
    homeDirectory = "/home/kswanson";
  };

  programs = {
    git = {
      userName = "Kimberly Swanson";
      userEmail = "Kimberly.Swanson@mako.com";
    };
  }
}
