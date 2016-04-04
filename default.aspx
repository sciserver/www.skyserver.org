<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="./contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer";
	string cvsRevision = "$Revision: 1.14 $";
	
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("SkyHeader.aspx" + "?" + Parameters);
%>
<p>
This site is intended to support people wishing to host a <a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casDBMS.pdf">SDSS Catalog Archive Server (CAS)</a> mirror site.
<p>
<!--
It contains the latest MySkyserver downloads - see <a href="myskyserver">MySkyServer</a>.  This is for people who want a personal (1.5GB) subset of the
CAS database to install on their laptop or personal desktop along with the SkyServer web interface.
<p> 
-->
The <a href="mirrors">SDSS Mirrors</a> page contains resources for those wishing to host a SDSS CAS mirror site.  
<p>
The <a href="mirrors/website.aspx"> SkyServer website</a> is also available for download. This is intended for those working on mirrors or translations.  Please see
the <a href="mirrors">SDSS Mirrors</a> link for more information.</p>
<p> 
You may also visit the <a href="http://skyserver.sdss.org">SDSS skyserver. </a>
<p>

<%	Server.Execute("SkyFooter.aspx" + "?" + Parameters);
%>
