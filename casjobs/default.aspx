<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS CasJobs Download Page";
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
<h2>CasJobs</h2>
<p>
You can download the <a href="http://skyserver.sdss.org/casjobs/">latest version of the CasJobs Batch Query Workbench</a>
 application here (see download link on the left or at the bottom of this page).
       <p>
            CasJobs is <a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casjobs.pdf">an online workbench for large scientific catalogs</a>, designed to emulate
            and enhance local free-form query access in a web environment.
        </p>
        <p>
            Some features of this application include...</p>
        <ul>
            <li>Both synchronous and asynchronous query execution, in the form of 'quick' and 'long'
                jobs.</li>
            <li>A query 'History' that records queries and their status. </li>
            <li>A server-side, personalized user database, called 'MyDB', enabling persistent table/function/procedure
                creation.</li>
            <li>Data sharing between users, via the 'Groups' mechanism.</li>
            <li>Data download, via MyDB table extraction, in various formats.</li>
            <li>Data upload, via the Import page, in various formats so you can upload your own data and use it in queries on SDSS data.</li>
            <li>Multiple interface options, including a browser client as well as a java-based command line tool.</li>
        </ul>

<h3>Downloading and Installing CasJobs</h3>
<p>
You can download the CasJobs package using the links below or on the left.  After you download and unzip the files, please look at the appropriate installation document  
for instructions on installing it, depending on the version you download and on the type of installation.  

<table border="1">
<tr>
	<th>CasJobs Download</th>
</tr>
</tr>
<tr>
<td>
<p>The latest version v4_0_0a requires Windows .NET Framework v4.0 or later, and Microsoft SQL Server 2008 R2 or later for all the features to work properly.  See also any specific scripts listed below that you might need to run for this upgrade.</u>.
</td>
</tr>
<tr>
<td>Installation doc: <span class="t">docs\installGuide.docx</span> </td>
<tr>
<td>
<h4>New CasJobs Installation</h4>
If this is the first time you are installing CasJobs, please load and execute the <span class="t">sql\batchadmin.sql</span> script in a 
SQL Server query window on the server that will host your BatchAdmin database.  You will need to be an admin user on 
that server.  The script creates various user logins with random passwords and disables the logins after creation
 (for security).  You need to change the passwords and enable the logins after the script is done.
<h4>Upgrading from an older CasJobs version</h4>
If you are upgrading an existing CasJobs site, it is best to 
replace the CasJobs directory with the downloaded one and follow the instructions in the installation guide.  Typically, you should rename the previous CasJobs directory so you can reuse the config files from it.  
Once you have downloaded and uncompressed the latest version, you should go to the <b>deploy</b> subdirectory and run the setup script for your installation/product (if applicable), e.g. <i>setup_sdss3.bat</i>.
</td>
</tr>
<tr>
<td class="t"><a href="../arcs/CasJobs_v4_0_0a.zip"><b>Download CasJobs v4_0_0a (requires at least .NET v4.0 and SQL Server 2008 R2)</b></a>.</td>
</tr>
</table>
<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
