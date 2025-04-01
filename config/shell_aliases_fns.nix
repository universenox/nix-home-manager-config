{ home-id, ... }:
let
  common_init = suffix: ''
    export HM_HOME_ID=${home-id}
    source $HOME/.shell-extra/initextra.${suffix}
  '';
in
{
  programs.bash.initExtra = common_init "sh";
  programs.zsh.initExtra = common_init "zsh";
}
