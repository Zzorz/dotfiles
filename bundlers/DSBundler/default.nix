{ pkgs, stdenv, writeScriptBin, ... }: drv:
let
  entry-script = writeScriptBin "${drv.pname}-entry" ''
    #!/bin/sh
    prog_name=$(basename $0)
    prog_path=$(dirname $(realpath $0))
    mountpoint=/tmp/${drv.name}


    function ctrl_c() {
        umount $mountpoint
        rmdir $mountpoint
    }
    trap ctrl_c INT




    if [[ "$prog_name" == ${drv.pname}-entry ]]
    then
        prog_name=$1
        if [[ "$prog_name" == "" ]]
        then
            echo "No program name was provided"
            exit 1
        fi
        shift
    fi


    if [[ ! -d $mountpoint ]]
    then
        mkdir $mountpoint
    else 
        umount $mountpoint 2>/dev/null
    fi



    $prog_path/squashfuse $prog_path/../${drv.name}.store $mountpoint
    $prog_path/bwrap --dev-bind / / --bind $mountpoint/nix /nix ${drv}/bin/$prog_name $@

  '';
in
stdenv.mkDerivation {
  pname = drv.pname;
  version = drv.version;
  closureInfo = pkgs.closureInfo { rootPaths = [ drv pkgs.bash ]; };
  bundledDrv = drv;
  buildCommand = ''
    mkdir -p $out/bin
    cd $out

    cp ${entry-script}/bin/${drv.pname}-entry $out/bin
    cp ${pkgs.pkgsStatic.bubblewrap}/bin/bwrap $out/bin
    cp ${pkgs.pkgsStatic.squashfuse}/bin/squashfuse $out/bin
    cp ${pkgs.pkgsStatic.dash}/bin/dash $out/bin/sh

    tar cf - $(< $closureInfo/store-paths) | ${pkgs.squashfsTools}/bin/mksquashfs - ${drv.name}.store -tar -no-recovery -no-strip -comp lz4 #zstd -Xcompression-level 1 

    cd $out/bin
    for i in $(ls $bundledDrv/bin);do
      ln -s ${drv.pname}-entry $(basename $i)
    done
  '';
}

