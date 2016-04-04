<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc"  -->
<% // fill this with your details 
	string Title = "SDSS Database Download";
	string cvsRevision = "$Revision: 1.6 $";
	Session["gselect"]=1;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>

<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<!-- comment -->
<p>
<h3>SDSS DR12 catalog data now available for download!</h3>
<p>The Sloan Digital Sky Survey's Data Release 12 catalog database, BestDR12 is available to mirror sites for download.  
The DR12 database is <a href="mailto:<%=sdss3email%>">available for FTP download from JHU</a>, the compressed data download size is 6.3 TB, whereas the uncompressed database requires 12 TB of storage. 
<p>
You can download <b><a href="restore-example.sql">an example of the restore script here.</a></b> 


<p>There is also an ZIP of the SkyServer website available. This is intended for those working on mirrors or translations.  Please click on the <b>Website</b> page in the menu to download the SkyServer website.

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
