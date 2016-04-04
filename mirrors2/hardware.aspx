<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SDSS Mirror Site Hardware Page";
	string author ="Ani R Thakar";
	string email ="thakar@jhu.edu";
	string cvsRevision = "$Revision: 1.2 $";
	Session["gselect"]=2;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>This page provides information on hardware needed to support a SDSS Catalog Archive Server mirror site.
<h3>Recommended Hardware Configuration</h3>
We don't recommend any specific vendor etc., but our latest DB server at FermiLab (FNAL) has the following 
hardware configuration:
<p>
        <dd>AMD Dual Opteron 248 (2 x 2.19 GHz processors)
        <dd>3.87 GB RAM
        <dd>24x400 GB SATA drives set up as 3 RAID10 arrays with stripe
        <dd><dd>  set at OS level for total 4.38 TB, 3Ware controllers
<p>
For DR7 and beyond these will be Quad (4-core) CPU servers.  You don't need to have RAID10, since 
you may not need that redundancy level for a mirror site, however it is recommended so you do not have to 
download the data again in case of a disk failure.  You will need 3+ TB (and 4+ TB or more if 
you're planning ahead for DR7 and beyond).  This is for only the Best database.  Currently mirror sites
do not keep a local copy of the Target dataset.
<p>
We generally recommend that the Web server and DB server be separate boxes, 
especially if you're supporting a large user community (100 or more).  For the 
webserver, any Windows box with Windows Server 2003 and IIS (preferably IIS 6 or later) 
running on it will do.  If you plan to support the CasJobs or ImgCutout services, you will 
definitely need a separate webserver with ASP.NET v2.0 or later installed on it.  
<p>
For our production cluster we also have 2-3 db servers per release, so 
that the public, collab and astro user levels can be adequately 
supported and skyserver and casjobs queries can be load-balanced on 
different boxes.  For a mirror site, you will not need that level of performance
unless you also plan to support multiple levels of access for a large user 
community.  The current configuration for multiple release support at FNAL is shown in 
Figure 1.  The hardware configuration and load balancing for CasJobs is shown in Figure 2.

<p><img src="../img/HW_config.jpg">Figure 1.  Hardware configuration at FNAL (FermiLab) for SDSS Servers.</img>
<p><img src="../img/cjobs_config.jpg">Figure 2.  Hardware configuration and load balancing for CasJobs queries.</img>
<p>
<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
