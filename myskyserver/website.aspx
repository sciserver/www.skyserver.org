<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "MySkyServer WebSite";
	string author ="William O'Mullane";
	string email ="womullan@jhu.edu";
	string cvsRevision = "$Revision: 1.8 $";
	
	Session["gselect"]=2;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>
<h3>Download the MySkyServer Web interface zip <a href="../arcs/MySkyServerWI.zip">MySkyServerWI.zip here</a>.</h3>
<p>
<h3>Installation Instructions</h3>

In addition to the installation instructions given below, please also ensure that your
IIS configuration has the "Enable Parent Paths" option turned on.



<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
