<%  @ LANGUAGE="JScript" %>
<!-------#include file="../../../x-utilities.js"------>
<!-------#include file="../../../globals.inc"------>
<!-------#include file="../crossid/adojavas.inc"------>
<!-------#include file="queryFuncs.js"------> 
<!------------#include file="../../../connection.js"-------->
<%

//  define a few useful regular expression globals for the parsing

	var reSignedFloat = /^((((\+|-)?\d+(\.\d*)?)|((\+|-)?(\d*\.)?\d+))([eE](\+|-){1}\d+)?)$/
	var reGator = /^\\\s+/
	var reSplit = /(\,|\s+)/
	var reSplitList = /(\s*(\,|\s)\s*)/
	var reName  = /"(\w+)"/	
	var reColon = /\w+: /
	var reBlank = /^\s*/
	var selectClause = "SELECT ";
	var fromClause = "FROM ";
	var whereClause = "WHERE ";
	
	var dbg = 0;
	var f = null;

	// check for QueryString if TotalBytes==0 (GET method)
	
	if (Request.TotalBytes==0)
		f = getQueryString();
		
	// otherwise get the Forms (POST method)

	else 
		f = getForms();

	if(dbg==1) {
		showForms(f); 
//		f= null;
	}
	
	if (f != null) {

		if ( f.format.value == "html") {
			Response.Write("<html><body>\n");
			Response.Write("<h2>Executing query ... </h2>\n");	
		}

		var cmd;
		cmd = buildQuery( oCmd, f, "img" );
		var cmdSplit = cmd.split( " " );
		if( dbg == 1 )
			showLine( "cmd start = "+cmdSplit[0]+"\n" );
		if( cmdSplit[0] == "ERROR:" )
			Response.Write( "<h3><font color=red>Error:</font> "+cmd+"</h3>\n" );
		else
			
			showTable( oCmd, cmd );
//			writeOutput( oCmd, cmd, "html" );
		
		if ( f.format.value == "html")
			Response.Write("</body></html>\n");
	}

%>
