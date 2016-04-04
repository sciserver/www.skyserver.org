// JavaScript file that creates the lab virtual directory structure
// using ADSI.

main();

function main() 
{
  var shell = WScript.CreateObject("WScript.Shell");

  var fso = new ActiveXObject('Scripting.FileSystemObject');
  var curPath = fso.GetFolder(".").Path;
  var newPath = "INST_ROOT" + "\\MySkyServerWI";
  var webSite = "Default Web Site"; // If no "Default Web Site" set here your Web server name

 
  // setup virtual directories
  
  WScript.Echo("Creating the virtual directory...");
    
  objSite = FindSite( "localhost", webSite);  	  	
  if (!objSite) {
	WScript.Echo( "\nERROR: Unable to find " + webSite + "."
				+ "\n\nUpdate webSite in MySkyServerWISetup.js");
  } 
  else {
	createApplication(webSite, "MySkyServer", "", newPath);
	createApplication( webSite, "ImgCutout", "", newPath+"\\services\\ImgCutout");
	WScript.Echo("\nSetup complete.");
  }
	
}

function createApplication(webSite, appName, parentName, appPath ) {
	var objApp;		
	try {
			// This may throw a COM exception
		objApp = objSite.Create( "IIsWebVirtualDir", "Root/"
					 + parentName 
					 + appName );
	}
	catch( e ) {
		objApp = objSite.GetObject( "IIsWebVirtualDir", "Root/" 
					    + parentName
					    + appName );
	}
			
	try {
		objApp.Path           = appPath;
		objApp.AccessRead     = true;
		objApp.AccessExecute  = false;
		objApp.AccessScript   = true;
		// objApp.AccessFlags =  529;
		objApp.SetInfo();
		objApp.AppCreate( false );   // in-proc
		objApp.SetInfo();           // commit
	}
	catch( e ) {
		displayError( "Create Application: " + strAppName, e, WScript );
	}	
}

// Using the ADSI interfaces, find the named web on the computer specified

function FindSite( strComputerName, strSiteName ) {

	var objWebSvc, objSiteEnum;

	objWebSvc = GetObject( "IIS://" + strComputerName + "/W3SVC" );
	objSiteEnum = new Enumerator( objWebSvc );
	
	for( ; !objSiteEnum.atEnd(); objSiteEnum.moveNext() ) {
		if( objSiteEnum.item().Class == "IIsWebServer" && 
			objSiteEnum.item().ServerComment == strSiteName )
			return objSiteEnum.item();
	}
	return null;
}
