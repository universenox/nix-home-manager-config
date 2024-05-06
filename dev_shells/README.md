# dev shells

I don't want to set up a nix env whenever I want to work on 
some coding project. This essentially provides a lazy quick-start with 
common dev dependencies, by language. I just run `nix develop <path/to/shell>` 
whenever I want to play around in that language.

If it becomes somewhat of an actual project / pulls in odd dependencies, I may
then create a proper nix env for it, using this as a starting point.
