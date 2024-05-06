{ helixpkg, themesDir, ... }:
{
  home.file.".config/helix/themes/".source = themesDir;
  home.file.".config/clangd/config.yaml".text = ''
    InlayHints:
      TypeNameLimit: 30
    Hover:
      ShowAKA: Yes
  '';
  home.file.".config/helix/languages.toml".text = ''
    use-grammars = { only = [ "cpp" ] }

    [language-server.clangd]
    command = "clangd"
    args = ["--background-index", 
            "--header-insertion=iwyu", 
            "--import-insertions",
            "--clang-tidy",
            "--all-scopes-completion", 
            "--completion-style=detailed", 
            "--function-arg-placeholders",
            "--pch-storage=memory"]

    [[language]]
    name = "cpp" 
    auto-format = true
    language-servers = [ { name = "clangd" } ]
    formatter = { command = "clang-format", args = ["--style=file:~/.config/home-manager/applications/shell/clang-format",  "--assume-filename=cpp.cpp"] }
  '';

  programs.helix =  {
    enable = true;
    package = helixpkg;
    defaultEditor = true;
    settings.editor = {
      rulers = [ 80 120 ];
    };
  };
}
