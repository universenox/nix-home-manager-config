This is my nix home-manager configuration. 
It runs on my primary machine which runs NixOS, and on two other machines 
that use other Linux distros where Nix just manages my ~.

Usage is ie:
`home-manager switch --flake ~/.config/home-manager/#home`

If contents of a subdirectory's flake are changed, it requires a 
call to `nix flake lock --update-input <input>` for the top-level flake.
