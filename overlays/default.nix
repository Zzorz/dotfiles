{ ... }:
{
  modifications = final: prev: {
    # example
    hello = prev.hello.overrideAttrs (oldAttrs: rec {
      version = "2.12";
      src = prev.fetchurl {
        url = "mirror://gnu/hello/hello-${version}.tar.gz";
        hash = "sha256-zwSvhtwIUmjF9EcPuuSbGK+8Iht4CWqrhC2TSna60Ks=";
      };
    });
  };
}
