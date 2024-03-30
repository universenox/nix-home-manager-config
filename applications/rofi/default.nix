{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wtype ];

  home.file.".config/rofi/ktheme.rasi".text =
    with config.colorScheme.palette;
    ''
      * {
        /* descriptors copied from helix base16 colors */
        base00: #${base00}; /* Default Background                                                       */
        base01: #${base01}; /* Lighter Background (Used for status bars, line number and folding marks) */                                                      
        base02: #${base02}; /* Selection Background                                                     */  
        base03: #${base03}; /* Comments, Invisibles, Line Highlighting                                  */                     
        base04: #${base04}; /* Dark Foreground (Used for status bars)                                   */                    
        base05: #${base05}; /* Default Foreground, Caret, Delimiters, Operators                         */                              
        base06: #${base06}; /* Light Foreground (Not often used)                                        */               
        base07: #${base07}; /* Light Background (Not often used)                                        */               
        base08: #${base08}; /* Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted        */                                               
        base09: #${base09}; /* Integers, Boolean, Constants, XML Attributes, Markup Link Url            */                                           
        base0A: #${base0A}; /* Classes, Markup Bold, Search Text Background                             */                          
        base0B: #${base0B}; /* Strings, Inherited Class, Markup Code, Diff Inserted                     */                                  
        base0C: #${base0C}; /* Support, Regular Expressions, Escape Characters, Markup Quotes           */                                            
        base0D: #${base0D}; /* Functions, Methods, Attribute IDs, Headings                              */                         
        base0E: #${base0E}; /* Keywords, Storage, Selector, Markup Italic, Diff Changed                 */                                      
        base0F: #${base0F}; /* Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>        */                                               
      }
    '' + builtins.readFile (./rofi-theme.rasi);

  programs.rofi = {
    enable = true;
    # emoji is broken :(
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,window,emoji";
      disable-history = false;
      show-icons = true;
    };
    theme = "ktheme";
  };
}
