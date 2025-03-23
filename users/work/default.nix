{ pkgs, ... }:
{
  # unused. just a ref.
  home = {
    username = "kswanson";
    homeDirectory = "/home/kswanson";

    packages = with pkgs; [
      # ...
    ];
  };
}
