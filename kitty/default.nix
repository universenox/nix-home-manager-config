{ lib, config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      background_opacity = "0.90";
      background_blur = 20;
      bell_on_tab = "🔔 ";
      scrollback_lines = 10000;
      theme = builtins.readFile ./Aquarium_Light.conf;
    };
  };
  # todo
  #home.packages = [
  #  {
  #    name = "kitty-fzf-preview";
  #    file = "bin/fzf-preview.sh";
  #    src = pkgs.fetchFromGithub{
  #      owner="junegunn";
  #      repo="fzf";
  #      rev="41d4d70b985f665c8ecc66b83aa10209c8dfbbfd";
  #      sha256="";
  #    };
  #  }
  #];
}
