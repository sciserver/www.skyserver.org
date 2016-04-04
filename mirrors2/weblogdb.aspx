<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SDSS SkyServer Weblog DB Page";
	string author ="Ani R Thakar";
	string email ="thakar@jhu.edu";
	string cvsRevision = "$Revision: 1.1 $";
	Session["gselect"]=6;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>The SDSS database(s) need a Weblog DB on the same server so that queries and web hits may be logged (and harvested in the future).

<h3>Download Weblog DB creation script:</h3> 
Click <b><u><a href="weblogDBcreate.sql">here to download the weblog Db creation script</a></u></b>.  
<p>
After downloading the script, you should load and execute it in SQL Query Analyzer (SQL Server 2000) or Management Studio (SQL Server 2005).  
You may want to check the script first to make sure the disk configuration matches your server.
</p>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
