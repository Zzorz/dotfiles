{ pkgs, stdenv, writeScriptBin, ... }: drv:
let
  entry-script = writeScriptBin "${drv.name}" ''
    #!/bin/sh
    prog_name=$(basename $0)
    prog_path=$(dirname $(realpath $0))
    bundle_path=$(dirname $prog_path)
    mountpoint=$bundle_path/nix

    
    if [ "$prog_name" = "${drv.name}" ]
    then
        prog_name=''${SHELL##*/}
    fi

    $prog_path/.bwrap \
      --dev-bind / / \
      --unsetenv PATH \
      --setenv PATH ${drv}/bin/:$PATH \
      --ro-bind "$mountpoint" /nix \
      $prog_name "$@"
  '';
in
stdenv.mkDerivation {
  name = drv.name+".tar.gz";
  closureInfo = pkgs.closureInfo { rootPaths = [ drv ]; };
  bundledDrv = drv;
  src = ./.;
  buildPhase= ''
    mkdir -p ${drv.name}/bin
    cp ${entry-script}/bin/${drv.name} ${drv.name}/bin

    cd ${drv.name}/bin
    for each in $(ls ${drv}/bin);do
      base=$(basename $each)
      if [ "${drv.name}" != $base ];then
        ln -s ${drv.name} $each 
      fi
    done
    cd ../../
    cp ${pkgs.pkgsStatic.bubblewrap}/bin/bwrap  ${drv.name}/bin/.bwrap

    cd ${drv.name}
    tar cf - $(< $closureInfo/store-paths) | tar xf -
    cd ../
  '';
  installPhase = ''
    tar czf $out ${drv.name}
  '';
}

