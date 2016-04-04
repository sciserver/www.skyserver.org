<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string author ="William O'Mullane";
	string email ="womullan.edu";
	string cvsRevision = "$Revision: 1.3 $";
	Session["gselect"]=3;
	string Parameters = "message="+Title+	"&"+"author="+author+"&leftMenu=gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>
<IMG SRC = "../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
<font color="#7700EE">HTM - Tested Platforms</font></h1>
<hr>
<br>

<ul>
<li>Linux (gcc 2.7 and up)
<li>MAC OSX 
<li>Microsoft Windows NT 4.0
<li>Microsoft Windows  XP
</ul>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);%>