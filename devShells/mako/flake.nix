{
  # Basically, if anything breaks because of the stuff we've done to our 
  # user environment, use this, and it *should* work.
  # use bash, not zsh, because zsh may be incompatible.
  description = "Minimal Mako Shell";
  inputs = {
  };
  outputs = inputs @ { ... }:
    {
      devShells.x86_64-linux.default = mkShell { 
        # set all the env stuff
        # note no packages are to be provided by nix.
        # the below bash script will do some environment magic and give us a $PATH with
        # the standard stuff.

        shellHook = ''
        source ~/.bashrc_mako
        '';
        MAKO_EXTERNAL_DIR="/srg/pro/release/external/";
        EXT_OS="CentOS9/x86_64";
        OS=EXT_OS;
        MAKO_ANACONDA_PATH="/srg/pro/release/external/anaconda3/bin";
      };
    };
}
