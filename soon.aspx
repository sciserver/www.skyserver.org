<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - coming soon";
	string author ="William O'Mullane";
	string email ="womullan@jhu.edu";
	string cvsRevision = "$Revision: 1.2 $";
	
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("SkyHeader.aspx" + "?" + Parameters);
%>
<!-- Your HTML or ASPX here --->
<h2>Coming Soon  </h2>

<%	Server.Execute("SkyFooter.aspx" + "?" + Parameters);
%>
