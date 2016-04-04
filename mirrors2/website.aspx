<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SDSS SkyServer Website Download Page";
	string author ="Ani R Thakar";
	string email ="thakar@jhu.edu";
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
<p>This page provides a link to the SDSS SkyServer Web Interface download and instructions for installing it, for SDSS Catalog Archive Server (CAS) mirror sites.

<h3>Download Website:</h3> 
Click <b><u><a href="../arcs/MySkyServerWI.zip">here to download a ZIP of the SkyServer website (version DR7_8)</a></u></b> (intended for those working on mirrors or translations).  
If you want only the English branch of the site (no multi-language support) click <b><u><a href="../arcs/MySkyServerWIen.zip">here to download a ZIP of the English branch.</a></u></b>.  
Please read the instructions below to install the Website.

<h3>Instructions for installing the SkyServer Website:</h3>
<ol>
	<li> Unzip the Website that you downloaded from the link above into a location in the C: drive on your Webserver machine.</li>
	<li> <b>Important:</b> Ensure that your IIS configuration has the "Enable Parent Paths" option turned on. </li>
	<li> Create a Virtual Directory that points to the top level of the directory where you extracted the website to.  This should
	     be the directory that is one level above the "en" subdirectory in the Website directory tree.  The URL to your site will
	     then be <b>http://localhost/&lt;vdirname&gt;</b>, where &lt;vdirname&gt; is the name (alias) of the virtual directory you create.
	     To create a virtual directory, you need to 
		<ul>
			<li>right-click on "My Computer" in the Start menu and select the "Manage" option. </li>
			<li>In the Computer Management browser, you then need to open the IIS ("Internet Information Services") tab.</li>
			<li>Under IIS, right-click on the "Default Web Site" or "Web Sites -> particular website" tab and select "New -> Virtual Directory". </li>
			<li>In the first Virtual Directory window, click Next to get the Alias window and set the alias to the name you want the site to have.</li>
			<li>Click Next to go to the path that this virtual directory points to.  Click Browse to select the top of the web tree that you extracted
			    the SkyServer Website to (the level above the "en" subdirectory.</li>
			<li>Click Next once more and then Finish to create the Virtual Directory.</li>
			<li>If you want to restrict access to your site, you can later right-click on the new virtual directory and open the Properties.  
			    The Directory Security tab contains options for restricting access to the site.</li>
		</ul> 
	   </li>
	<li> Copy the <b>globals.inc.cvs</b> file at the top level of the website tree to <b>globals.inc</b> in the same directory.</li>
	<li> Edit the <b>globals.inc</b> file as necessary to set the local parameters and paths for your mirror site.  In
	     particular, set at least the values of the <b>access</b>, <b>releaseNumber</b>, <b>userpwd</b> and <b>server</b> variables.</li>
	     The remaining variable values can be set on an as needed basis for your local configuration.  If you have a local
	     version of the CasJobs or ImgCutout services, then you will need to modify the URLs for those.</li>
	<li> Try the new site by opening a browser and typing the URL "http://localhost/&lt;vdirname&gt;".  You may replace "localhost" with
	     the name of the server. </li>
</ol>
<p>
That's it ... your SkyServer mirror site is ready to go!  If you have problems with the installation, please contact the <a href="mailto:thakar@jhu.edu">SkyServer helpdesk</a>.
<p>
(Note: If you want to mirror the ImgCutout Web service also, you can <b><a href="../arcs/imgcutout.zip">download it here</a></b>).

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
