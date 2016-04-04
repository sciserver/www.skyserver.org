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
<p>This site is intended to support people wishing to create a SDSS Catalog Archive Server mirror site.  

<h5><a href="http://skyserver.sdss.org/dr12/">SDSS DR12 catalog data</a> is now available for download, please contact <a href="mailto:<%=sdss3email%>">JHU SDSS CAS support</a> for further information.</h5>

<b>Patch for version 6 of BestDR12:</b><br>
If you are already hosting a DR12 mirror, there is <a href="../arcs/dr12patchV6.zip">a new patch available</a> that fixes some important issues.  Please <a href="../arcs/dr12patchV6.zip">download the patch here</a> and follow the instructions in the README file.

<p>
In order to create a mirror site, you need to perform the following steps:
<ol>
   <li>Purchase the webserver (Windows .NET Server 2008) and DB server <a href="hardware.aspx">hardware</a> that meets the space 
	 and performance requirements for the SDSS dataset that you want to mirror.  See the <a href="hardware.aspx">Hardware page</a> for more information.</li>
   <li>Purchase or obtain a Microsoft SQL Server 2008 R2 licence.  See the <a href="mssql.aspx">SQL Server page</a> for more information.</li>
   <li>Install SQL Server 2008 R2 along with the recommended service packs on the DB server.</li>
   <li>Download the data for the <a href="subsets.aspx">SDSS dataset</a> that you have chosen (this is in the form of SQL Server database files).  
       The main SDSS databases and some smaller subsets are available on the <a href="subsets.aspx">SDSS-III CAS DB Download page</a> (see <a href="subsets.aspx">DB Download link</a> in the left menu).</li>
   <li>Download the <a href="website.aspx">SDSS-III SkyServer web site</a> to the webserver and install the SkyServer Web Interface to the Catalog Archive Server. </li>
   <li>If you want to be able to execute patches and scripts released from time to time to fix problems in the latest SDSS-III dataset, then you should <a href="loader.aspx">(click on sqlLoader in the menu on the left) download the sqlLoader product</a> and install it as instructed on your database server(s).</li>
   <li>Finally, if you want to mirror the <a href="http://skyserver.sdss.org/casjobs/">CasJobs site</a> as well, then you should click on the <a href="http://www.skyserver.org//casjobs">CasJobs link</a> on the menu above to download the latest version of CasJobs.</li>
</ol>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
