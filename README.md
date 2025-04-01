This is my nix home-manager configuration. 
It runs on two NixOS machines with the same configuration, and
I use a slightly modified version for work where it just manages my ~.

Usage is ie:
`home-manager switch --flake ~/.config/home-manager/#home`

If contents of a subdirectory's flake are changed, it requires a 
call to `nix flake lock --update-input <input>` for the top-level flake.
