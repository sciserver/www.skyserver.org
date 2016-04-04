<%
	//
	// the connection commands to the SkyServer database
	// change only this file in order to update connections
	//
	var oConn   = Server.CreateObject("ADODB.Connection"); 
	var oCmd    = Server.CreateObject("ADODB.Command");
	var strConn = "Provider=SQLOLEDB;User ID=weblog;Password=weblog7377;";
	strConn	   += "Initial Catalog=weblog;Data Source=weblog.pha.jhu.edu"; 
	oConn.Open(strConn);
	oCmd.ActiveConnection = oConn;
%>
