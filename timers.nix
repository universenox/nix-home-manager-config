{ pkgs, ...}:
{
  # export task list so that I can read it on my phone easily.
  systemd.user = 
    let tw-task = "taskwarrior-export"; in {
    timers.${tw-task} = {
      Timer = {
        OnUnitActiveSec = "30";
        OnBootSec = "10";
      };
    };
    services.${tw-task} = {
      Service = {
        Type = "oneshot";
        RemainAfterExit="yes";
        ExecStart = toString (
          pkgs.writeShellScript "taskwarrior-export" 
          ''${pkgs.taskwarrior}/bin/task > ~/Documents/tasklist.txt''
        );
      };
    };
  };
} 

