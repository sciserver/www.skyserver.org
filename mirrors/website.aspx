<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS SkyServer Website Download Page";
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
<p>This page provides a link to the SDSS SkyServer Web Interface download and instructions for installing it, for SDSS-III Catalog Archive Server (CAS) mirror sites.

<h3>Download Website (DR12 version):</h3> 
Please click <b><u><a href="../arcs/SkyServerDR12_v1.0.0.zip">here to download a ZIP of the DR12 SkyServer website version DR12_v1.0.0</a></u></b> (intended for those working on mirrors or translations).  
</u></b>.  
Please read the instructions below to install the Website.

<h3>Instructions for installing the SkyServer Website:</h3>
<ol>
	<li> You will need ASP.NET v4.0 or later on your Web server to host the DR10 SkYServer website.</li>
	<li> Unzip the Website that you downloaded from the link above into a location in the C: drive on your Webserver machine.</li>
	<li> <b>Important:</b> Ensure that your IIS configuration has the "Enable Parent Paths" option turned on. </li>
	<li> Create a Virtual Directory that points to the top level of the directory where you extracted the website to.  This should
	     be the directory that is one level above the "en" subdirectory in the Website directory tree.  The URL to your site will
	     then be <b>http://localhost/&lt;vdirname&gt;</b>, where &lt;vdirname&gt; is the name (alias) of the virtual directory you create.
	   </li>
	<li> Edit the <b>Web.config</b> file as necessary to set the local parameters and paths for your mirror site.  In
	     particular, set at least release number and server connection string variables.</li>
	     The remaining variable values can be set on an as needed basis for your local configuration.  If you have a local
	     version of the CasJobs or ImgCutout services, then you will need to modify the URLs for those.</li>
	<li> Try the new site by opening a browser and typing the URL "http://localhost/&lt;vdirname&gt;".  You may replace "localhost" with
	     the name of the server. </li>
</ol>
<p>
That's it ... your SkyServer mirror site is ready to go!  If you have problems with the installation, please contact the <a href="mailto:<%=sdss3email%>">SkyServer helpdesk</a>.
<p>
(Note: If you want to mirror the ImgCutout Web service also, you can <b><a href="../arcs/ImgCutoutDR12.zip">download it here</a></b>).

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
