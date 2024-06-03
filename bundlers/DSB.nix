{ writeShellScript, writeShellScriptBin, ... }: drv:
writeShellScript "entry" ''
  ${drv}/bin/$(basename $0) $@
''

