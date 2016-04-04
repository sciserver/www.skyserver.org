!define SERVICE_STOPPED                0x00000001
!define SERVICE_START_PENDING          0x00000002
!define SERVICE_STOP_PENDING           0x00000003
!define SERVICE_RUNNING                0x00000004
!define SERVICE_CONTINUE_PENDING       0x00000005
!define SERVICE_PAUSE_PENDING          0x00000006
!define SERVICE_PAUSED                 0x00000007
Function SSInstalledAndRunning
  nsSCM::QueryStatus /NOUNLOAD "MSSQLSERVER"
  Pop $0 ; return error/success
  Pop $1 ; return service status
  StrCmp $0 "success" ssinstalled
    MessageBox MB_ICONSTOP|MB_OK "SQL Server is not installed.  Please install it and then rerun this program."
    abort "SQL Server is not installed.  Please install it and then rerun this program."
  ssinstalled:
  StrCmp $1 "4" ssrunning
    MessageBox MB_ICONEXCLAMATION|MB_YESNO "SQL Server is not currently running.  Would you like to start it now?  'No' will exit the installer." IDYES true IDNO false
  true:
    nsSCM::Start /NOUNLOAD "MSSQLSERVER"
    Pop $0 ; return error/success
    StrCmp $0 "success" ssrunning
    MessageBox MB_ICONSTOP|MB_OK "Failed to start SQL Server.  Please start it manually, and then rerun this installer"
    abort "Failed to start SQL Server.  Please start it manually, and then rerun this installer"
    goto ssrunning
  false:
    abort "Please start SQLServer manually and then rerun this installer"
  ssrunning:
  DetailPrint "SQL Server is installed and running"
FunctionEnd


;-------------------------------
; by me
; sets ss to mixedmode-auth. restarts ss
Function SSMixedMode
  ClearErrors
  ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\MSSqlserver\MSSqlServer" "LoginMode"
  StrCmp $0 "0" mixedAuthSet
    DetailPrint "Setting SQL Server to use mixed-mode authentication..."
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\MSSqlserver\MSSqlServer" "LoginMode" 0x00000000
    MessageBox MB_ICONEXCLAMATION|MB_YESNO "SQL Server should now be restarted in order for some changes to take effect.  Would you like to restart SQL Server now?  'No' will exit the installer." IDYES true IDNO false
  true:
    nsSCM::Stop /NOUNLOAD "MSSQLSERVER" ;stop it
    Pop $0 ; return error/success
    StrCmp $0 "success" pt2
    MessageBox MB_ICONSTOP|MB_OK "Failed to stop SQL Server.  Please restart it manually, and then rerun this installer"
    abort "Failed to stop SQL Server.  Please restart it manually, and then rerun this installer"
    pt2:
      loop: ; poll till it's stopped
        Sleep 500 ;half a second
        nsSCM::QueryStatus /NOUNLOAD "MSSQLSERVER"
        Pop $0 ; return error/success
        Pop $1 ; return service status
        StrCmp $0 "success" nextstep
           abort "ERROR!: Unknown error polling SQL Server status."
        nextstep:
        StrCmp $1 "1" loopout
        goto loop
     loopout:
     nsSCM::Start /NOUNLOAD "MSSQLSERVER" ;do it
     StrCmp $0 "success" mixedAuthSet
     MessageBox MB_ICONSTOP|MB_OK "Failed to start SQL Server.  Please restart it manually, and then rerun this installer"
     abort "Failed to start SQL Server.  Please restart it manually, and then rerun this installer"
  false:
    abort "Please restart SQLServer manually and then rerun this installer"
  mixedAuthSet:
  DetailPrint "SQL Server is set to mixed-mode authentication"
FunctionEnd