{ home-id, ... }:
let
  common_initextra = ''
    export HM_HOME_ID=${home-id}
    source $HOME/.shell-extra/initextra.sh
  '';
in
{
  programs.bash.initExtra = common_initextra;
  programs.zsh.initExtra = common_initextra;
}
