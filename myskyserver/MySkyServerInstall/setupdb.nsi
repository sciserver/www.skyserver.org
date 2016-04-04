;-------------------------------
; by me
;INST_ROOT, MS_SS_ROOT
Function SetupDB
  ReadRegStr $0 HKLM SOFTWARE\Microsoft\MSSQLServer\Setup\ "SQLDataRoot"
  DetailPrint "SQL Server is installed at $0"
  GetTempFileName $1
  CopyFiles "ss1.sql" $1
  !insertmacro ReplaceInFile "$1" "MS_SS_ROOT" "$0"
  !insertmacro ReplaceInFile "$1" "INST_ROOT" "$INSTDIR"
   nsExec::ExecToLog /TIMEOUT=20000 '"osql" -E -i $1 -n'
   
   GetTempFileName $1
   CopyFiles "ss2.sql" $1
   !insertmacro ReplaceInFile "$1" "PW_PL" "$password"
   nsExec::ExecToLog /TIMEOUT=20000 '"osql" -E -i $1 -n'
FunctionEnd



