{ lib, config, pkgs, ... }:
{
  imports = [
    ../../common.nix
  ];

  home = {
    username = "kswanson";
    homeDirectory = "/home/kswanson";

    shellAliases = {
      regen_clangdb = "ninja -C build-clang -t compdb > compile_commands.json";
      env = "/bin/env";

      # if you wish to restore to mako env (and break nix)
      # remove ~/.bashrc and copy over the /srg/pro/env/bashrc one.
      # can restore nix by just adding PATH=~/.nix-profile/bin then blah blah.
      # for mako env, put nix stuff last. Note this can be problematic!!!
      mako = ''source ~/.mako-env/bash_alias && source ~/.mako-env/bashrc && PATH=$PATH:~/.nix-profile/bin'';
      makoz = ''mako && source ~/.zshrc'';
    };

    # our goto dev shell.
    packages = with pkgs; [
      clang_17
      clang-tools_17
      gdb
      valgrind
      kcachegrind
      gnumake
      cmake
      ninja
      doxygen
      cmake-format
      ccache

      # perms, never....
      # (python311.withPackages (p: with p; [
      #   bugwarrior
      # ]))
    ];
  };
  programs =
    let
      # idk why it is not done automatically (path to packages in $PATH).
      # be careful, system packages are old, and may accidentally use them...
      # TODO: sim_env breaks some stuff...
      shellInitExtra = ''
        PATH=~/.nix-profile/bin:/home/kswanson/bin:$PATH
        source ~/export_proxy.sh
        source ~/bash_extra.sh
      '';
    in
    {
      git = {
        userName = "Kimberly Swanson";
        userEmail = "Kimberly.Swanson@mako.com";
      };

      bash = {
        enable = true;
        # Note that there is this pattern where scripts source $HOME/.bashrc.
        # and it just absolutely breaks stuff. See my .mako-env for workaround.
        bashrcExtra = shellInitExtra;
      };
      zsh = {
        initExtra = shellInitExtra;
      };
      gnome-terminal = {
        enable = true;
        profile = {
          "928e9795-7801-410c-a094-c5349daa1c6d" = {
            default = true;
            visibleName = "Zsh";
            customCommand = "${pkgs.zsh}/bin/zsh";
          };
          "972dd800-0473-4551-b875-b2737355b053" = {
            default = false;
            visibleName = "Bash";
          };
        };
      };
    };
}
