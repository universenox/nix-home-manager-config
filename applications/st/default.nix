{ config, pkgs, inputs, ... }:
let 
    palette = config.colors.colorScheme.palette;
    colorized_drv = (pkgs.callPackage ./colorized_conf.nix { pkgs=pkgs; palette=palette; });
    colorized_conf = (builtins.readFile "${colorized_drv}/conf.h");
in
{
    home.file.".st_conf.h".text = colorized_conf;
    home.packages = [
        (pkgs.st.override { 
            conf = colorized_conf; 
            patches = with inputs; [ 
                p-ligature 
                p-anysize
                p-fullscreen
                p-appsync
                ./truecolor.patch
            ];
            extraLibs = with pkgs; [ harfbuzz ];
        })
    ];

    # some programs (like helix) depend on this to detect.
    home.sessionVariables = {
        COLORTERM = "truecolor";
    };
}


