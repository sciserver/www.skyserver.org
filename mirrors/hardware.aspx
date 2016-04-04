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
<p>This page provides information on hardware needed to support a SDSS Catalog Archive Server (CAS) mirror site.
<h3>Recommended Hardware Configuration</h3>
<p>
We generally recommend that the Web server and database (DB) server be separate boxes, 
especially if you're supporting a large user community (100 or more).  For the 
webserver, any Windows box with Windows Server 2008 and IIS7 (or later) 
running on it will do.  If you plan to support the CasJobs or ImgCutout services, you will definitely need a separate webserver with ASP.NET v2.0 or later installed on it.  
</p>
<p>
We don't recommend any specific vendor etc., but our DR12 DB servers as well as MyDB servers at JHU have the following hardware configuration:
</p>
<ul>
	<li>Intel Xeon 24-core CPU ES-2630v2 (2x12) @2.60GHz 64GB RAM  </li>
	<li>Network Adapter: Broadcom bcm5709c netxtreme ii gige </li>
	<li>RAID controllers: Intel C600 SATA </li>
	<li>Disks configured to RAID 5 with 2 logical volumes of 8.2 TB each and 2 dedicated TempDB volumes. Each hard drive is 700GB @10000 RPM.</li>
</ul>
<p>
All MyDB databases are hosted on 2 database servers, one of them being online at any given time.  
<p>
For our production cluster we have 3-4 db servers per release, so 
that the public and collab users as well as CasJobs users can be adequately 
supported, and skyServer, ImgCutout and CasJobs queries can be load-balanced on 
different boxes.  We dedicate one server to ImgCutout queries for multiple releases, since these queries can be quite large in number and intensive.  
</p>
<p>
At any given time, we have 2 or more DB servers in production per release, and the rest are used for testing and data loading purposes. Quick and long queries are pointed to two separate servers.  One of the two MyDB servers will be in production and the other one is used for warm backup (MyDBs are bakced up daily to the backup machine).
</p>
<p>
For a mirror site, you may not need the full configuration described above unless you want to ensure a high level of performance for multiple levels of access across a large user community.  
</p>

The current configuration for multiple release support at JHU is shown in 
Figure 1.  

<!-- The hardware configuration and load balancing for CasJobs is shown in Figure 2.  -->

<p><img src="../img/dr12_hW_config.jpg" width="960">Figure 1. DR12 Hardware configuration at JHU for SDSS Servers.</img>

<!-- <p><img src="../img/cjobs_config.jpg">Figure 2.  Hardware configuration and load balancing for CasJobs queries.</img> -->
<p>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
