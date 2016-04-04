<%  @ LANGUAGE="JScript" %>
<!-- #include file="../../x-utilities.js" -->
<!---#include file="../../connection.js"-------->
<% 

	Response.Buffer = true;

	//	read in query     
	var c		= Request.form("cmd");
	var format  = Request.form("format");
	var syntax  = Request.form("syntax");

 	if (String(c) == "undefined" )
  		{c = Request.QueryString('cmd');}

	if (String(format) == "undefined" ) 
  		{format = Request.QueryString('format');}

 	if (String(syntax) == "undefined" )
  		{syntax = Request.QueryString('syntax');}

	var c2 = String(c).replace(/\/\*(.*\n)*\*\//g,"");	// remove all multi-line comments
	c2 = c2.replace(/^[ \t\f\v]*--.*\r\n/gm,"");		// remove all isolated single-line comments
	c2 = c2.replace(/--[^\r^\n]*/g,"");				// remove all embedded single-line comments
	c2 = c2.replace(/[ \t\f\v]+/g," ");				// replace multiple whitespace with single space
	c2 = c2.replace(/^[ \t\f\v]*\r\n/gm,"");			// remove empty lines
	c = c2;								// make a copy of massaged query
	c2 = c2.replace(new RegExp("'","g"),"''");		// 'c' is query version that's printed on output page
										// 'c2' is the version that is sent to DB server

	var nw = new ActiveXObject("WScript.Network");
	var windows_name = nw.ComputerName;
	var server_name = Request.ServerVariables("SERVER_NAME");
	var remote_addr = Request.ServerVariables("REMOTE_ADDR");

	if( syntax == "Syntax" ) {
		// if syntax check only is desired, add line numbers to query
		var clines = c.split("\n");
		c = "<i>Line#</i>\n";
		for( i=0; i < clines.length; i++ ) {
			if( (i < (clines.length-1)) || (clines[i].length > 0) ) {
				if( (i+1) < 10 ) 
					c += "<i>" + String(i+1) + ".</i>   " + clines[i];
				else if( (i+1) < 100 )
					c += "<i>" + String(i+1) + ".</i>  " + clines[i];
				else
					c += "<i>" + String(i+1) + ".</i> " + clines[i];
			}
		}
			
		// prefix with "set parseonly on" to invoke SQL syntax check
		var cmd = "EXEC spExecuteSQL '" + "set parseonly on " + c2 +"  ', " + 1000000 + ",'" + server_name + "','" + windows_name + "','" + remote_addr + "','weblog'" ;
		writeSyntaxMessage( oCmd,cmd, c );		// ignore output format, call special output function for syntax
	} else {
		var cmd = "EXEC spExecuteSQL '" + c2 +"  ', " + 1000000 + ",'" + server_name + "','" + windows_name + "','" + remote_addr + "','weblog'" ;

		oConn.CommandTimeout = 3600;
		oCmd.CommandTimeout = 3600;
		Server.ScriptTimeout = 3600;
		
		writeOutput(oCmd,cmd,c,format);
	}
%>