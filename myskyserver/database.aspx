<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "My SkyServer DataBase";
	string author ="Ani Thakar";
	string email ="thakar@jhu.edu";
	string cvsRevision = "$Revision: 1.5 $";
	Session["gselect"]=1;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>
<h3>Download the database zip <a href="../arcs/MySkyServerDR3_CD/MyBestDR3.zip">MyBestDR3.zip here</a>.</h3>
<p>
<h3>Installation Instructions</h3><pre>
<!--  #include file="../arcs/MySkyServerDR3_CD/ReadmeBeforeInstalMyBestDR3.txt" -->
</pre>
<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
