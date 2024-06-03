{ pkgs, stdenv, writeShellScript, writeShellScriptBin, ... }: drv:
let
  entry-script = writeShellScriptBin "${drv.pname}-entry" ''
    prog_name=$(basename $0)
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
    ${drv}/bin/$prog_name $@
  '';
in
stdenv.mkDerivation {
  pname = drv.pname;
  version = drv.version;
  closureInfo = pkgs.closureInfo { rootPaths = [ drv ]; };
  bundledDrv = drv;
  buildCommand = ''
    mkdir -p $out/nix/store
    mkdir -p $out/bin
    cd $out

    cp ${entry-script}/bin/${drv.pname}-entry $out/bin

    for i in $(< $closureInfo/store-paths); do
      cp -a "$i" "$out/$i"
    done

    cd $out/bin
    for i in $(ls $bundledDrv/bin);do
      ln -s ${drv.pname}-entry $(basename $i)
    done
  '';
}

