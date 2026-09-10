{
  appimageTools,
  src,
}:

appimageTools.wrapType2 {
  pname = "duckstation";
  version = "latest";
  inherit src;
  extraPkgs =
    pkgs:
    (with pkgs; [
      qt6.qtbase
      qt6.qtsvg
      libGL
      vulkan-loader
      wayland
      libx11
      libxcursor
      libxi
      libxrandr
    ]);
}