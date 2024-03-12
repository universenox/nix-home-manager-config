{ themesDir, ... }:
{
  home.file.".config/helix/themes/".source = themesDir;
  home.file.".config/helix/languages.toml".text = ''
    use-grammars = { only = [ "cpp" ] }

    [language-server.clangd]
    command = "clangd"
    args = ["--background-index", "--header-insertion=iwyu", "--import-insertions"]

    [[language]]
    name = "cpp" 
    auto-format = true
    formatter = { command = "clang-format", args = []}
    language-servers = [ { name = "clangd" } ]
  '';

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.editor = {
      rulers = [ 80 120 ];
    };
  };
}
