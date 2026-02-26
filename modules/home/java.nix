{
  pkgs,
  ...
}:
let
  additionalJDKs = with pkgs; [
    openjdk8
    openjdk11

    jdk8

    zulu11
    zulu25

    (zulu17.override { enableJavaFX = true; })
    (zulu8.override { enableJavaFX = true; })
    (jdk17.override { enableJavaFX = true; })
    (jdk21.override { enableJavaFX = true; })
  ];
in
{
  home.sessionPath = [ "$HOME/.jdks" ];
  home.file = (
    builtins.listToAttrs (
      builtins.map (jdk: {
        name = ".jdks/${jdk.version}";
        value = {
          source = jdk;
        };
      }) additionalJDKs
    )
  );

  home.packages = with pkgs; [
    openjfx
    libxxf86vm # required native library for JavaFX

    recaf-launcher
    bytecode-viewer
  ];
}
