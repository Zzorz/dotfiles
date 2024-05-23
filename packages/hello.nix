{ lib, stdenv, fetchurl, ... }:
stdenv.mkDerivation rec {
  pname = "hello";
  version = "2.12.1";
  src = fetchurl {
    url = "https://mirrors.tuna.tsinghua.edu.cn/gnu/hello/${pname}-${version}.tar.gz";
    sha256 = "jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
  };
}
