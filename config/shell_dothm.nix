# Accomodating
# - Common version-controlled (VC'd) config
# - Module-specific VC'd config
# - Typical non-VC'd config
# - Bash and Zsh
#
# Aiming to keep all realised config in basically one place (${outLinkDir}) -- easier to view.
{ home-id, lib, ... }:
let
  inherit (lib) concatStringsSep;

  # ref paths have optional subdirs [ "config" "bin" "shell-extra"]
  # shell-extra has optional files [ "common-initextra" "bash-initextra" "zsh-initextra" ]
  commonRefPath = "$HOME/.config/home-manager/directly-refd";
  moduleRefPath = "$HOME/.config/home-manager/users/${home-id}/directly-refd";
  outLinkDir = "$HOME/.hm"; # created by home.activation

  # "common" refers to both for zsh and bash shells.
  common_init = shellType: ''
    export HM_HOME_ID=${home-id}
    export PATH=${lib.concatStringsSep ":" [
      "${moduleRefPath}/bin"
      "${commonRefPath}/bin"
      "$HOME/.nix-profile/bin" # works on nixos but not standalone? not sure how it works but let's make sure we have our pkgs in PATH
      "$HOME/bin" 
      "$PATH" 
    ]}

    source_if_exists(){
      file=$1
      if [[ -f $file ]]; then
        source $file
      fi
    }
    mkdir_if_not_exist(){
      dir=$1
      if [[ ! -d $dir ]]; then
        mkdir -p $dir
      fi
    }
    export source_if_exists
    export mkdir_if_not_exist

    # top-level, common shell config
    source_if_exists ${outLinkDir}/shell/common/common-initextra
    source_if_exists ${outLinkDir}/shell/common/${shellType}-initextra

    # module-specific shell config
    source_if_exists ${outLinkDir}/shell/${home-id}/common-initextra
    source_if_exists ${outLinkDir}/shell/${home-id}/${shellType}-initextra
  '';
in
rec {
  xdg.systemDirs.config = [
    "${outLinkDir}/config/${home-id}" # module-specific VC'd config
    "${outLinkDir}/config/common" # generic VC'd config
    "$HOME/.config" # non VC'd config
  ];
  programs.bash.initExtra = (common_init "bash");
  programs.zsh.initExtra  = (common_init "zsh");

  # Lots of config does not belong in nix. It's very dynamic / doesn't utilize any nix stuff.
  # So, we just use nix to create the symlinks.
  # Rely on version control.
  # Create a tree of symlinks in ${outLinkDir} with this VC'd configuration
  home.activation = {
    directlink = lib.hm.dag.entryAfter [ "writeBoundary" ] (''
      source_if_exists(){
        file=$1
        if [ -f $file ]; then
          $DRY_RUN_CMD source $file
        fi
      }
      mkdir_if_not_exist(){
        dir=$1
        if [ ! -d $dir ]; then
          $DRY_RUN_CMD mkdir -p $dir
        fi
      }

      mkdir_if_not_exist ${outLinkDir}
      mkdir_if_not_exist ${outLinkDir}/shell
      mkdir_if_not_exist ${outLinkDir}/config

      # common shell stuff
      $DRY_RUN_CMD ln -sfvn ${commonRefPath}/shell-extra ${outLinkDir}/shell/common
      # module shell stuff
      $DRY_RUN_CMD ln -sfvn ${moduleRefPath}/shell-extra ${outLinkDir}/shell/${home-id}

      # common xdg config
      $DRY_RUN_CMD ln -sfvn ${commonRefPath}/config ${outLinkDir}/config/common
      # module xdg config
      $DRY_RUN_CMD ln -sfvn ${moduleRefPath}/config ${outLinkDir}/config/${home-id}

      ####
      # Check XDG config dirs don't have clashes (to avoid confusion)
      ####
      xdg_dirs=(${concatStringsSep " " xdg.systemDirs.config})
      existing_xdg_dirs=()
      for x in "''${xdg_dirs[@]}"; do [[ -e "$x" ]] && existing_xdg_dirs+=("$x"); done

      members=$(mktemp)
      for x in "''${existing_xdg_dirs[@]}"; do
        realpath $x/* >> $members
      done
      members_basename=$(mktemp)
      cat $members | xargs basename -a > $members_basename 
     
      clashes=$(sort $members_basename | uniq -d)
      if [[ -n "$clashes" ]]; then
        echo "WARNING: XDG_CONFIG_DIRS (''${existing_xdg_dirs[@]}) has clashes:"
        grep -f <(echo -e "$clashes") $members
      fi
    '');
  };
}
