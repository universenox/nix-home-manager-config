{ pkgs, home-id, ... }:
{
  home.packages = with pkgs; [ delta ];
  programs.git = {
    enable = true;
    # see git aliases in shell/ alias config.

    aliases = {
      "co"             = "checkout";
      "cm"             = "commit";
      "s"              = "status";
      "a"              = "add -A";
      "d"              = "diff";
      "wip"            = ''commit -m "WIP"'';
      "rerere-clearall"= ''rm -rf ./.git/rr-cache/''; # oopsie. 
      "lightclone" = "git clone --depth=1 --sparse";
    };

    # see man git-config
    extraConfig = {
      core.untrackedCache = true;
      core.fsmonitor = true;
      maintenance = {
        schedule = if (home-id == "work") then "hourly" else "weekly";
      };
      fetch.writeCommitGraph = true;
      column.ui.auto = "auto";
      branch.sort = "-committerdate";
      branch = {
        autoSetupMerge = true;
        autoSetupRebase = "always"; # pull rebases instead of merge
        fetch = { 
          prune = true; 
          pruneTags = true;
        };
        pull = { rebase = true; };
        rebase = {
          autoSquash = true;
          autoStash = true; # before rebase, then applies after.
        };
        merge = {
          ff = "only";
          log = true;
        };

      };
      rerere = {
        # reuse recorded resolutions
        enabled = true;
        autoUpdate = true;
      };

      # better diff viewer
      core.pager = "${pkgs.delta}/bin/delta";
      interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
      delta.navigate = true;
    };
    ignores = [ "*~" "*.swp" "*.sync-conflict*" ".stfolder*" "*.orig" "./result/" "**/__pycache__/"];
  };
}
