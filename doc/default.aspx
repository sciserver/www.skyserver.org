<%@ Page language="c#" Debug="true"%>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServerOrg - Documentation";
	string cvsRevision = "$Revision: 1.5 $";
	Session["gselect"]=0;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<h2>SkyServer Documents   </h2>
The following is a list of documents relating to the SDSS CAS (Catalog Archive Server), including the <a href="http://skyserver.sdss.org/">SkyServer 
web interface</a>, the <a href="http://skyserver.sdss.org/casjobs/">CasJobs batch query workbench</a>, and the <a href="http://skyservice.pha.jhu.edu/loadstatus">
sqlLoader data loading pipeline</a>.

<ol>
	<li><a href="Thakar_CAS_DataReview.pdf">Catalog Archive Server slides for SDSS-IV Data Review held at JHU, October 15-16, 2014. (PDF)</a>: Slides for the CAS presentation at the data review.</li>
	<li><a href="CASoverview.pdf">Overview of the SDSS Catalog Archive Server (PDF)</a>: A general description of the CAS architecture and its main components.
		This document references several articles published in the IEEE/ACM journal "Computing in Science and Engineering". These articles are listed below
		as well for convenience (with links to the PDF files).</li>
 	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casLessons.pdf">Thakar, A.R. 2008: Lessons Learned From The SDSS Catalog Archive Server, 
		<i>Computing in Science and Engineering</i>, 10, 6 (Nov/Dec 2008), 65.</a></li>
	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/intro.pdf">Thakar, A.R. 2008: The Sloan Digital Sky Survey: Drinking from the Fire Hose, 
		<i>Computing in Science and Engineering</i>, 10, 1 (Jan/Feb 2008), 9.</a></li>
	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casjobs.pdf">Li, N. and Thakar, A.R. 2008: CasJobs and MyDB: A Batch Query Workbench, <i>Computing in Science and Engineering</i>, 10, 1 (Jan/Feb 2008), 18.</li>
	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/casDBMS.pdf">Thakar, A.R., Szalay, A.S., Fekete, G., and Gray, J. 2008: The Catalog Archive Server Database Management System, <i>Computing in 
		Science and Engineering</i>, 10, 1 (Jan/Feb 2008), 30.</a></li>
	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise08/sqlLoader.pdf">Szalay, A.S., Thakar, A.R., and Gray, J. 2003: The sqlLoader Data Loading Pipeline, Computing in Science and Engineering, 10, 1 (Jan/Feb 2008), 38.</li>
	<li><a href="http://www.sdss.jhu.edu/~thakar/pubs/cise03/SDSS.pdf">Thakar, A.R., Szalay, A.S., Kunszt, P.K., Gray, J. 2003, &quot;The Sloan Digital Sky Survey Science Archive: Migrating A Multiterabyte Archive from Object to
     		Relational Databases&quot;, <i>Computing in Science and Engineering</i>, vol. 5, no. 5 (Sep/Oct 2003), pp16-29</a>.<o:p></o:p></b></li>
	<li><a href="..\help\sqlLoader.htm">CAS Loader (sqlLoader) User Guide</a>.</li>
	<li><a href="LoggingOverview.pdf">SkyServer usage logging overview</a> and <a href="http://skyserver.sdss.org/log/en/traffic/">SkyServer traffic page.<a></li>

</ol>
There is also a <a href="sitemap.aspx">sitemap </a> outlining the structure of the site.
</p>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
