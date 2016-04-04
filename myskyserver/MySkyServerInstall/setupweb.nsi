;-------------
; by me
!define JS ".js"
Function SetupWeb
  !insertmacro ReplaceInFile "$INSTDIR\MySkyServerWI\globals.inc" "xxxxxxxx" "$password"

  GetTempFileName $1
  StrCpy $1 '$1${JS}'
  CopyFiles "websetup.js" $1

  ${StrReplace} $0 "$INSTDIR" "\" "_"
  ${StrReplace} $0 "$0" "_" "\\"
  DetailPrint ">>> $0"
  
  !insertmacro ReplaceInFile "$1" "INST_ROOT" "$0"
  nsExec::ExecToLog /TIMEOUT=20000 '"$SYSDIR\cscript.exe" "$1"'
FunctionEnd
