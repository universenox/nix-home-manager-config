{pkgs, palette}:
pkgs.stdenv.mkDerivation {
  pname = "kim-colorized-configs";
  version = "0.0.1";
  src = ./conf.h;
  installPhase = ''
  mkdir -p $out
  cp $src $out/conf.h
  '';
  phases = [ "installPhase" "postPatch" ];
  postPatch = ''
    substituteInPlace "$out"/conf.h \
      --replace "@base00@" "#${palette.base00}" \
      --replace "@base01@" "#${palette.base01}" \
      --replace "@base02@" "#${palette.base02}" \
      --replace "@base03@" "#${palette.base03}" \
      --replace "@base04@" "#${palette.base04}" \
      --replace "@base05@" "#${palette.base05}" \
      --replace "@base06@" "#${palette.base06}" \
      --replace "@base07@" "#${palette.base07}" \
      --replace "@base08@" "#${palette.base08}" \
      --replace "@base09@" "#${palette.base09}" \
      --replace "@base0A@" "#${palette.base0A}" \
      --replace "@base0B@" "#${palette.base0B}" \
      --replace "@base0C@" "#${palette.base0C}" \
      --replace "@base0D@" "#${palette.base0D}" \
      --replace "@base0E@" "#${palette.base0E}" \
      --replace "@base0F@" "#${palette.base0F}" 
  '';
}
