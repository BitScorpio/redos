{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    trezor-suite
    dysk

    stockfish
    pychess

    playerctl

    # media
    makemkv
    ffmpeg
    mkvtoolnix

    # misc
    chromium
    digital
    kdePackages.kalarm
  ];
}
