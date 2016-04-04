;--------------------------------
; CheckIISVersion Function
;
; This is built off MSFT's required keys for IIS
; (info at http://nsis.sf.net/wiki)
; and the NSIS Wiki (http://nsis.sf.net/wiki).
Function CheckIISVersion

	ClearErrors
	ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\InetStp" "MajorVersion"
	ReadRegDWORD $1 HKLM "SOFTWARE\Microsoft\InetStp" "MinorVersion"

	IfErrors 0 NoAbort

        MessageBox MB_ICONINFORMATION|MB_OK "Please install IIS and then rerun this installer."

	Abort "${PRODUCT_NAME} ${PRODUCT_VERSION} web interface requires Microsoft Internet Information Server (IIS) to be installed.  Please install IIS before continuing."

	IntCmp $0 5 NoAbort IISMajVerLT5 NoAbort

	NoAbort:
		DetailPrint "Found Microsoft Internet Information Server v$0.$1"
		Goto ExitFunction

	IISMajVerLT5:
		Abort "Setup could not detect Microsoft Internet Information Server v5 or later; this is required for installation. Setup will abort."

	ExitFunction:

FunctionEnd

;-----------------------
; by me
;starts up default website
Function IISStarted
   nsExec::ExecToLog /TIMEOUT=20000 '"$SYSDIR\cscript.exe" startweb.vbs -a 1'
FunctionEnd