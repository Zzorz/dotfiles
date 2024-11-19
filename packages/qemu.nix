{
  stdenv,
  fetchurl,
  pkgs,
  ...
}:
stdenv.mkDerivation rec {
  pname = "qemu";
  version = "9.0.0";
  src = fetchurl {
    url = "https://download.qemu.org/${pname}-${version}.tar.xz";
    hash = "sha256-MnCKxmww2MiSYz6paMdxwcdtWX1w3erSGg0izPOG2mk=";
  };
  dontUseMesonConfigure = true;
  nativeBuildInputs = with pkgs; [
    pkg-config
    flex
    bison
    dtc
    meson
    ninja
    python3Packages.python
    python3Packages.sphinx
    python3Packages.sphinx-rtd-theme
  ];
  buildInputs = with pkgs; [
    zlib
    glib
    pixman
    vde2
    texinfo
    lzo
    snappy
    libtasn1
    gnutls
    nettle
    curl
    libslirp
  ];
  preConfigure = ''
    chmod +x ./scripts/shaderinclude.py
    patchShebangs .
    substituteInPlace  meson.build --replace "subdir('tests')" "#subdir('tests')"
  '';
  configureFlags = [
    "--disable-docs"
    "--disable-system"
    "--enable-user"
    "--disable-install-blobs"
    "--target-list=arm-linux-user,aarch64-linux-user,x86_64-linux-user,i386-linux-user,mips-linux-user,mips64-linux-user"
  ];
  preBuild = "cd build";
}
