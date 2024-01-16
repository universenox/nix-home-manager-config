{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
  ];

  home = {
    username = "kswanson";
    homeDirectory = "/home/kswanson";

    sessionVariables = {
      TERMINAL="gnome-terminal";
      SHELL ="${pkgs.zsh}/bin/zsh";
    };

    shellAliases = {
      regen_clangdb="ninja -C build-clang -t compdb > compile_commands.json";
    }
  };

  programs = 
  let 
    # idk why it is not done automatically (path to packages in $PATH).
    # also very concerning is the hash changes every time i rebuild
    # and date is wrong, why it says 1970-01-01 !?
    # btw, be careful, system packages are old, and may accidentally use them...
    addProfileToPath = ''
    PATH=/home/kswanson/.nix-profile/bin:$PATH
    ''; 
    # note, connection fails...
    setProxy = ''
    source ~/export_proxy.sh
    ''; 
  in 
  {
    git = {
      userName = "Kimberly Swanson";
      userEmail = "Kimberly.Swanson@mako.com";
    };
    bash = {
      enable = true;
      initExtra = addProfileToPath + setProxy;
    };
    zsh.initExtra = addProfileToPath + setProxy;
    gnome-terminal = {
       enable = true;
       profile = {
          "928e9795-7801-410c-a094-c5349daa1c6d" = {
            default=true;
            visibleName="My Default Config";
            customCommand="/usr/bin/env SHELL=${pkgs.zsh}/bin/zsh ${pkgs.zsh}/bin/zsh";
          };
       };
    };
  };
}
