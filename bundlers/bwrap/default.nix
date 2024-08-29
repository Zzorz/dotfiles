{ pkgs, stdenv, writeScriptBin, ... }: drv:
let
  entry-script = writeScriptBin "${drv.name}" ''
    #!/bin/sh
    prog_name=$(basename $0)
    prog_path=$(dirname $(realpath $0))
    mountpoint=''${mountpoint:-/opt/${drv.name}/nix}

    ctrl_c() {
        umount $mountpoint
        rmdir $mountpoint
    }
    trap ctrl_c INT




    if [ "$prog_name" = "${drv.name}" ]
    then
        prog_name=sh
    fi

    $prog_path/bwrap \
      --dev-bind / / \
      --unsetenv PATH \
      --setenv PATH ${drv}/bin/:${pkgs.pkgsStatic.dash}/bin/:$PATH \
      --ro-bind "$mountpoint" /nix \
      $prog_name "$@"
  '';
in
stdenv.mkDerivation {
  name = drv.name;
  closureInfo = pkgs.closureInfo { rootPaths = [ drv ]; };
  bundledDrv = drv;
  buildCommand = ''
    mkdir $out
    tar cf - $(< $closureInfo/store-paths) > $out/${drv.name}.tar
    tar rf $out/${drv.name}.tar -C ${entry-script} bin/${drv.name}
    tar rf $out/${drv.name}.tar -C ${pkgs.pkgsStatic.bubblewrap} bin/bwrap 
    tar --transform "s|/bin/dash|/bin/sh|" -rf $out/${drv.name}.tar ${pkgs.pkgsStatic.dash}/bin/dash
    gzip $out/${drv.name}.tar 
  '';
}

