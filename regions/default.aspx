<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - Regions";
	string cvsRevision = "$Revision: 1.3 $";
	
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<!-- Your HTML or ASPX here --->
<h2>Regions in SQL Server  </h2>
Paper about zones and regions.<br>
<a href="http://research.microsoft.com/research/pubs/view.aspx?tr_id=736">There Goes the Neighborhood: Relational Algebra for Spatial Data Search</A><br>
 Alexander S. Szalay, Gyorgy Fekete, Wil O’Mullane, Maria A. Nieto-Santisteban, Aniruddha R. Thakar, Gerd Heber, Arnold H. Rots.<br>
 MSR-TR-2004-32, April 2004
<h2> Region Syntax </h2>
<a href="Region.doc">BNF etc for region syntax.(this is in word format)</a>

<h2> How to install </h2>
Download and install instructions ... for now see <a href="../skynode/"> the sky node install </a>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
