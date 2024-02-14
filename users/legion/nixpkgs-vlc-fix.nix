{ ... }:
{
  # resolves
  # https://github.com/NixOS/nixpkgs/issues/283083
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     vlc = prev.vlc.override { ffmpeg = prev.ffmpeg_4; };
  #   })
  # ];
}
