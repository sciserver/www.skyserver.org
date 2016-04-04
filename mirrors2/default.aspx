<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS Mirror Site Resource Page";
	string cvsRevision = "$Revision: 1.12 $";
	Session["gselect"]=0;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>This site is intended to support people wishing to create a SDSS II Catalog Archive Server mirror site.  If you wish to host an SDSS-III mirror, please use the <a href="../mirrors3">SDSS-III mirrors link</a>.
<h5><a href="http://cas.sdss.org/dr7">SDSS DR7 catalog data</a> is now available for download, please see <a href="subsets.aspx">the download page</a> for further information.</h5>
In order to create a mirror site, you need to perform the following steps:
<ol>
   <li>Purchase the webserver (Windows .NET Server 2003) and DB server <a href="hardware.aspx">hardware</a> that meets the space 
	 and performance requirements for the SDSS dataset that you want to mirror.  See the <a href="hardware.aspx">Hardware page</a> for more information.</li>
   <li>Purchase or obtain a Microsoft SQL Server 2005 licence.  See the <a href="mssql.aspx">SQL Server page</a> for more information.</li>
   <li>Install SQL Server 2005 along with the recommended service packs on the DB server.</li>
   <li>Download the data for the <a href="subsets.aspx">SDSS dataset</a> that you have chosen (this is in the form of SQL Server database files).  
       The main SDSS databases and some smaller subsets are available on the <a href="subsets.aspx">SDSS CAS DB Download page</a> (see <a href="subsets.aspx">DB Download link</a> in the left menu).</li>
   <li>Download the <a href="website.aspx">SDSS SkyServer web site</a> to the webserver and install the SkyServer Web Interface to the Catalog Archive Server. </li>
</ol>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
