{
  description = "ST (suckless terminal)";
  inputs = {
    p-ligature = {
        url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20240105-0.9.diff";
        flake = false;
    };
    p-anysize = {
        url = "https://st.suckless.org/patches/anysize/st-expected-anysize-0.9.diff";
        flake = false;
    };
     p-fullscreen = {
         url = "https://st.suckless.org/patches/fullscreen/st-fullscreen-0.8.5.diff";
         flake = false;
    };
    p-appsync = { # requires autosync
         url = "https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff";
         flake = false;
    };
    p-font2 = { 
         url = "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff";
         flake = false;
    };
  };
  outputs = inputs@{ ... }:
  {
    homeManagerModules.default = { config, lib, pkgs, colors, ...}: (import ./default.nix { inherit config lib pkgs colors inputs; });
  };
}
