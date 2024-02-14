{ ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      # see man git-config
      branch = {
        autoSetupMerge = true;
        autoSetupRebase = "always";
        fetch = { prune = true; };
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
    };
    ignores = [ "*~" "*.swp" "*.sync-conflict*" ".stfolder*" ];
  };
}
