{ ... }:
{
  programs.zsh = {
      shellAliases = { 
        cppshell = "nd ~/.config/home-manager/dev_shells/cpp";
        pyshell  = "nd ~/.config/home-manager/dev_shells/python";
      };

      # so then you can do ie ''la $(fdd F)'' or ''cat $(fdf F)''.
      shellGlobalAliases = {
          fdd   = "fd -t d";
          fdf   = "fd -t f";
          fdcpp = "fd -e hpp -e h -e c -e cpp";
          F     = " | fzf";
          T     = " | tail";
          H     = " | head";
          "LL"  = "2>&1 | less";
          "CA"  = "2>&1 | cat -A";
          "NE"  = "2 > /dev/null";
          "NUL" = "2 > /dev/null";
      };

      initExtra = ''
        # be aware: aliases defined in shellHook will not work.
        nd() { nix develop "$1" --command zsh; } 
      '';
  };
}
