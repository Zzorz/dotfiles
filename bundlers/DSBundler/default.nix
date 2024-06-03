{ writeShellScript, writeShellScriptBin, ... }: drv:
writeShellScript "${drv.name}-entry" ''
  prog_name=$(basename $0)
  if [[ "$prog_name" == ${drv.name}-entry ]]
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
''

