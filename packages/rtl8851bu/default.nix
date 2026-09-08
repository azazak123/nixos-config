{
  stdenv,
  kernel,
  bc,
  src,
}:

stdenv.mkDerivation {
  pname = "rtl8851bu";
  version = "v1.19.10";

  inherit src;

  nativeBuildInputs = [ bc ];
  hardeningDisable = [ "pic" ];

  makeFlags = [
    "ARCH=x86_64"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  prePatch = ''
    substituteInPlace Makefile --replace "-Werror" ""
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8851bu
    install -m 644 8851bu.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8851bu
  '';
}