<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS SkyServer sqlLoader Download Page";
	string cvsRevision = "$Revision: 1.12 $";
	Session["gselect"]=3;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>This page provides a link to the <a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/sqlLoader.pdf">SDSS SkyServer data loading pipeline (sqlLoader)</a> download and instructions for installing it, for <a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casDBMS.pdf">SDSS Catalog Archive Server (CAS)</a> mirror sites.

<h3>Download sqlLoader (DR12 version):</h3> 
Please click <b><u><a href="../arcs/sqlLoader.zip">here to download a ZIP of the DR12 SkyServer loader</a></u></b> (intended for those working on mirrors or translations).  
</u></b>. 
Please read the instructions below to install the Website.

<h3>Instructions for installing the SkyServer Website:</h3>
<ol>
	<li> After you download the sqlLoader and unzip the directory, please install it in the C: drive of your database server (where the SDSS BestDRx database lives).  There should be a directory called <b>C:\sqlLoader</b> on that server if you want to run patches and scripts released from time to time.</li>
	<li> Please also make sure that there is a <b>C:\Temp</b> directory on that same server (create one if necessary) that has write access for all users.  Scripts run from sqlLoader will send log output to the C:\Temp directory, so if things go wrong you can look at the logs deposited there (.txt files).</li>
</ol>
<p>
That's it! You are ready to run patches and scripts now by loading them in SQL Server Management Studio on that server and clicking Execute. </li>
</p>
<p> 
If you are not downloading sqlLoader to use on an SDSS mirror site, then you don't have to follow these instructions.  You can look at the documentation included in the <b>doc</b> subdirectory for how to adapt and use the loader for your data.  Note that it is only possible at the moment to use it with SQL Server data. A full description of the sqlLoader data loading pipleline appeared in <a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/sqlLoader.pdf">this 2008 article on sqlLoader that appeared in Computing in Science and Engineering</a>.  There is also an <a href="http://www.sdss.jhu.edu/~thakar/sqldoc/sqlLoader.htm">online sqlLoader user guide available</a>, but it is meant for loading SDSS data.</li>
</p>
<p>
<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
