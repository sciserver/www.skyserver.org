<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc"  -->
<% // fill this with your details 
	string Title = "SDSS DB Download";
	string cvsRevision = "$Revision: 1.6 $";
	Session["gselect"]=1;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>

<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<!-- comment -->
<p>
<h3>SDSS DR7 catalog data now available for download!</h3>
<p>The Sloan Digital Sky Survey's Data Release 7 catalog database, BestDR7 is available to the public for download.  
The entire BestDR7 database and the DR6 catalog databases are distributed by the <b><a href="http://www.ncdm.uic.edu">National Center for Data Mining (NCDM) 
at the University of Illinois, Chicago (UIC)</a></b>, whereas smaller subsets of the catalog data are available on demand from JHU.  
<p>
Please go to the <b><a href="http://sdss.ncdm.uic.edu/download.html">SDSS data download page at NCDM</a></b> to download the DR7 or DR6 data, or 
<b><a href="mailto:thakar@jhu.edu">contact JHU</a></b> for other (smaller) datasets.  
<p>
You will need at least <u><i>twice</i> the size of the dataset available on disk</u> to restore the database from the backup that you will download.  
This does not all have to be on the same drive, as you can restore from a different (network-mounted) drive than the one hosting the database.
On the drive that contains the restored database, <u>it is recommended that you have about 1.3-1.5 times the space needed for the data itself</u>, to allow
for tempdb expansion and log file expansion.
<p>
You can download <b><a href="restore-example.sql">an example of the restore script here.</a></b> 

<!--
<h4>DR6 Datasets</h4>
Currently only the monolithic BestDR6 and SegueDR6 datasets are available.  In the near future, the multi-volume version of BestDR6 and subsets will also be available.
<p>
<table border='2' width='720'>
<tr><td class='s'><i>Database</i></td><td class='s'><i>Size</i></td><td class='s'><i>Description</i></td><td class='s'><i>Location</i></td><td class='s'><i>Checksum</i></td></tr>
<tr><td class='b'>BestDR6</td><td class='b'>2.6 TB </td><td class='b'>The entire dataset - The SDSS DR6 "gold" version of the catalog database containing the best photometry spectra and tiling data</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>21720510422</td></tr>
<tr><td class='b'>SegueDR6</td><td class='b'>0.6 TB </td><td class='b'>The <a href="http://www.sdss.org/segue/aboutsegue.html">SEGUE</a> dataset - The <a href="http://www.sdss.org/dr6/start/aboutsegue.html">SEGUE imaging footprint from the DR6 release</a> in a separate database.</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>4873331242</td></tr>
</table>

<h4>DR5 Datasets</h4>
<table border='2' width='720'>
<tr><td class='s'><i>Database</i></td><td class='s'><i>Size</i></td><td class='s'><i>Description</i></td><td class='s'><i>Location</i></td><td class='s'><i>Checksum</i></td></tr>
<tr><td class='b'>BestDR5</td><td class='b'>2.1 TB </td><td class='b'>The entire dataset - The SDSS DR5 "gold" version of the catalog database containing the best photometry spectra and tiling data</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>19235758619</td></tr>
-->
<!-- 
<tr><td class='b'>TargDR5</td><td class='b'>1.8 TB </td><td class='b'>Target Selection snapshot of the entire dataset - photometric (imaging) data only</td><td class='b'>11617406484</td></tr>  
<tr><td class='b'>BestDR5_EFG</td><td class='b'>2.1 TB </td><td class='b'>BestDR5_EFG is a multi-volume copy of BestDR5 in which the data tables are spread across 3 disk volumes (E,F,G) for better performance</td><td class='b'>JHU</td><td class='b'>19235758619</td></tr>
<tr><td class='b'>BestDR5_100GB</td><td class='b'>138 GB </td><td class='b'>BestDR5_100GB is a subset of BestDR5 in region ra between 180 and 215 and dec between -5 and 15</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>1200323363</td></tr>
<tr><td class='b'>BestDR5_100GB_EFG</td><td class='b'>138 GB </td><td class='b'>BestDR5_100GB_EFG is a multi-volume copy of BestDR5_100GB </td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>1200323363</td></tr>
<tr><td class='b'>BestDR5_Spec</td><td class='b'>111 GB </td><td class='b'>BestDR5_Spec is a subset of BestDR5 containing data for all objects that have spectra (photoobj.specObjID &gt; 0)</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>259880393</td></tr>
<tr><td class='b'>BestDR5_10GB</td><td class='b'>13 GB </td><td class='b'>BestDR5_10GB is a subset of BestDR5 in region RA between 190 and 200 and dec between 0 and 6</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>108641528</td></tr>
<tr><td class='b'>BestDR5_10GB_EFG</td><td class='b'>13 GB </td><td class='b'>BestDR5_10GB_EFG is a multi-volume copy of BestDR5_10GB</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>108641528</td></tr>
<tr><td class='b'>MyBestDR5</td><td class='b'>1.7 GB </td><td class='b'>MyBestDR5 is a personal-size subset of BestDR5 in region ra between 193.75 and 196.25 and dec between 1.25 and 3.75</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a>/JHU</td><td class='b'>13715932</td></tr>
<tr><td class='b'>BestDR5WrapAround</td><td class='b'>1.3 GB </td><td class='b'>BestDR5WrapAround is a subset of BestDR5 in the wraparound region ((RA between 0 and 1)  or (RA between 359 and 360)) and dec between -1 and 1</td><td class='b'><a href="http://sdss.ncdm.uic.edu">NCDM</a></td><td class='b'>9821972</td></tr>
</table>
-->
<!--
<h4>DR4 Datasets</h4>
<table border='2' width='720'>
<tr><td class='s'><i>Database</i></td><td class='s'><i>Size</i></td><td class='s'><i>Description</i></td><td class='s'><i>Location</i></td><td class='s'><i>Checksum</i></td></tr>
<tr><td class='b'>BestDR4</td><td class='b'>1.8 TB </td><td class='b'>The entire dataset - The SDSS DR4 "gold" version of the catalog database containing the best photometry spectra and tiling data</td><td class='b'>NCDM</td><td class='b'>15261774234</td></tr>
<tr><td class='b'>TargDR4</td><td class='b'>1.6 TB </td><td class='b'>Target Selection snapshot of the entire dataset - photometric (imaging) data only</td><td class='b'>11617406484</td></tr> 
<tr><td class='b'>BestDR4_EFG</td><td class='b'>1.8 TB </td><td class='b'>BestDR4_EFG is a multi-volume copy of BestDR4 in which the data tables are spread across 3 disk volumes (E,F,G) for better performance</td><td class='b'>JHU</td><td class='b'>15261473241</td></tr>
<tr><td class='b'>BestDR4_100GB</td><td class='b'>143 GB </td><td class='b'>BestDR4_100GB is a subset of BestDR4 in region ra between 180 and 215 and dec between -5 and 15</td><td class='b'>JHU</td><td class='b'>1145844072</td></tr>
<tr><td class='b'>BestDR4_100GB_EFG</td><td class='b'>143 GB </td><td class='b'>BestDR4_100GB_EFG is a multi-volume copy of BestDR4_100GB </td><td class='b'>JHU</td><td class='b'>1145844072</td></tr>
<tr><td class='b'>BestDR4_Spec</td><td class='b'>84 GB </td><td class='b'>BestDR4_Spec is a subset of BestDR4 containing data for all objects that have spectra (photoobj.specObjID &gt; 0)</td><td class='b'>JHU</td><td class='b'>209246569</td></tr>
<tr><td class='b'>BestDR4_10GB</td><td class='b'>10 GB </td><td class='b'>BestDR4_10GB is a subset of BestDR4 in region RA between 190 and 200 and dec between 0 and 6</td><td class='b'>JHU</td><td class='b'>104112385</td></tr>
<tr><td class='b'>BestDR4_10GB_EFG</td><td class='b'>10 GB </td><td class='b'>BestDR4_10GB_EFG is a multi-volume copy of BestDR4_10GB</td><td class='b'>JHU</td><td class='b'>104112385</td></tr>
<tr><td class='b'>MyBestDR4</td><td class='b'>1.5 GB </td><td class='b'>MyBestDR4 is a personal-size subset of BestDR4 in region ra between 193.75 and 196.25 and dec between 1.25 and 3.75</td><td class='b'>JHU</td><td class='b'>12818131</td></tr>
<tr><td class='b'>BestDR4WrapAround</td><td class='b'>1.2 GB </td><td class='b'>BestDR4WrapAround is a subset of BestDR4 in the wraparound region ((RA between 0 and 1)  or (RA between 359 and 360)) and dec between -1 and 1</td><td class='b'>JHU</td><td class='b'>9076095</td></tr>
</table>
-->

<p>There is also an ZIP of the SkyServer website available. This is intended for those working on mirrors or translations.  Please click on the <b>Website</b> page in the menu to download the SkyServer website.
<!--
To download a self-contained personal DR5 subset (MySkyServerDR5), please click the <a href="../myskyserver/">MySkyServer<a> link.</p>
-->

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
