{ pkgs, home-id, ... }:
{
  home.packages = with pkgs; [ delta ];
  programs.git = {
    enable = true;

    aliases = {
      # get one branch, one commit. 
      # tmpclone       = "clone --depth=1 --branch=<branch> <url>";
      blobless-clone = "clone --filter=blob:none";
      treeless-clone = "git clone --filter=tree:0";
      
      co             = "checkout";
      cob            = "checkout -b";

      cm             = "commit";
      cman           = "commit --amend --no-edit --date=now";
      wip            = ''commit -m "WIP"'';
      
      s              = "status";
      a              = "add -A";
      d              = "diff";
      ds              = "diff --staged";

      changedfiles = "diff-tree --no-commit-id -r --name-only";
      logp = "log --graph --pretty=format:’%C(cyan)%h%Creset %Cgreen(%cr) %C(magenta)<%an>%Creset -%C(yellow)%d%Creset %s’ --abbrev-commit --date=relative";
      
      rerere-clearall = ''rm -rf ./.git/rr-cache/''; # oopsie.
      stag = "tag -l --sort=v:refname";
      wl = "worktree list";

      who = "shortlog -s -- ";
      unstage = "restore --staged";
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
      };
      fetch = { 
        prune = true; 
        pruneTags = true;
      };
      push = { 
        default = "simple"; 
        autoSetupRemote = true;
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
      rerere = {
        # reuse recorded resolutions
        enabled = true;
        autoUpdate = true;
      };

      # better diff viewer. can override:
      # GIT_PAGER="delta <args...>"
      # -s, --side-by-side
      # --wrap-max-lines="unlimited"
      # --max-line-length=0
      core.pager = "${pkgs.delta}/bin/delta";
      interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
      delta.navigate = true;
    };
    ignores = [ "*~" "*.swp" "*.sync-conflict*" ".stfolder*" "*.orig" "./result/" "**/__pycache__/" ".cache/" "*.bak" ];
  };
}
 
