<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS Mirrors - Frequently Asked Questions";
	string cvsRevision = "$Revision: 1.1 $";
	Session["gselect"]=5;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<ol>
  <li><b>Why is the size of the full catalog data for a given release different (less than) the catalog data size shown on the 
         <a href="http://www.sdss.org/">sdss.org</a> page for that release?</b>
      <p>The catalog data size shown on sdss.org includes the size of the <b>target</b> dataset, which is a separate database 
         containing the version of the data that the spectroscopic targets were selected from.  We do not distribute the target
         dataset to mirror sites.  It is only required for a very small fraction of queries and we ask that you go
         to the <a href="http://cas.sdss.org/">main SDSS CAS site</a> for those queries that require the target dataset.</p>
  </li>
 
  <li><b>What about the raw (FITS) image and spectroscopic data?  How do I get the raw data for a given SDSS data release?</b>
      <p>The raw data is not served by the CAS (Catalog Archive Server), rather it is available from a different Fermilab site
         called <a href="http://das.sdss.org/">DAS (Data Archive Server)</a>.  The raw data may become available at some point 
         the <a href="http://sdss.ncdm.uic.edu">SDSS NCDM data distribution site</a>, but until then you can contact the 
         <a href="mailto:sdss-helpdesk@fnal.gov">SDSS Help Desk</a> to ask how you can get the raw imaging and spectroscopic data.
         Be warned that the raw data is a factor of 3-4 times the size of the catalog data.</p>
  </li>

  <li><b>Why are there checksums included in the data subsets table for each subset?</b>
      <p>The checksum is a quantity we generate based upon the schema and data in that particular version of each subset of the
         database, and it provides a verification of that version.  You can use the value of the checksum, found in the SiteConstants
         or Versions table, to check that the version you have is exactly the same as what is distributed.  Note that this checksum 
         is different from the MD5 checksum(s) used to verify the data transfer itself.</p>
  </li>
</ol>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
