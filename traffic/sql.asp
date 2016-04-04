<!-------#include file="../header.inc"---------->
<%	var gselect=5.3;%>
<style>
	#waiting {position:absolute;top:500;left:180;}
</style>
<script SRC="naviclass.js"></script>
<title>SkyServer Weblog Search</title>
<!-------#include file="../banner.inc"---------->
<!-------#include file="./gutter.inc"-------------->

<div id="title">Weblog SQL Search</div>

<div id="transp">
<form method ="post" target="search" name="sql" action="x_sql.asp">
<script>
function goToWindow() {
	var w = window.open("",'search');
	w.focus();
	
}
</script>


<table BORDER=0 WIDTH="600"  cellpadding=1 cellspacing=1>
	<tr VALIGN=top><td><p>Please see below for WebLog and SqlLog schema information.  This query page has a timeout of 10 minutes.
	For batch query access to the Weblog DB, please use <a href="http://skyservice.pha.jhu.edu/casjobs/">the JHU CasJobs batch query workbench.</a>
  	<p>
	</td></tr>
	
	<tr><td class='t'>
	</td></tr>
	<tr VALIGN=top><td>
		<textarea cols=80 name=cmd rows=12 wrap=virtual>
SELECT TOP 10 *
FROM Weblog       -- or FROM SqlLog
WHERE
    yy=datepart(yy,getdate()) and mm=datepart(mm,getdate()) and dd=datepart(dd,getdate())
</textarea> 
	</td></tr>
<!--
	<tr><td>
		<table BORDER=0 WIDTH="100%" >
		  <tr>
			<td ALIGN=left width="10%">Format</td>
			<td width="30%"><input name=format value="html" type=radio class="box" CHECKED>HTML</td>
			<td width="30%"><input name=format value="xml"  type=radio class="box">XML</td>
			<td width="30%"><input name=format value="csv"  type=radio class="box">CSV</td>
			</tr>

		</table>
	</td></tr>
-->
	<tr><td>
		<table width="100%"><tr>
		<td width="10%">
<%
if( access == "public" )
	Response.Write("\t\t<input id=submit type=submit value=Submit onclick=\"goToWindow()\">\n");
else
	Response.Write("\t\t<input id=submit type=submit value=Submit>\n");
%>
		</td>
		<td width="27%">&nbsp;
		<input TYPE="checkbox" VALUE="Syntax" id="syntax" name="syntax">Check Syntax Only?
		</td>
		<td width="5%">&nbsp;</td>
		<td width="48%" class='t'>
			<table BORDER=0 WIDTH="100%" >
			  <tr>
				<td ALIGN=left width="35%">Output Format</td>
				<td width="23%"><input name=format value="html" type=radio class="box" CHECKED>HTML</td>
				<td width="23%"><input name=format value="xml"  type=radio class="box">XML</td>
				<td width="23%"><input name=format value="csv"  type=radio class="box">CSV</td>
				</tr>
			</table>
		</td>
		<td width="10%">
		<input TYPE="reset" VALUE="Reset " id="reset" name="reset" color="#00FFFF">
		</td>
		</tr>
		</table>
	</td></tr>

  
</table>
</form>

<h3>WebLog Columns</h3>
<p>The weblog information -- contains visible log records.  The information is parsed from the W3C <br>
format weblog files, generated on each web server by IIS. </p>
<table border=1>
<th>Name</th> <th>Type</th> <th>Description</th>
<tr><td>yy 		</td><td>smallint		</td><td>the year of the event</td></tr>
<tr><td>mm 		</td><td>tinyint		</td><td>the month of the event</td></tr>
<tr><td>dd 		</td><td>tinyint		</td><td>the day of the event</td></tr>
<tr><td>hh	      </td><td>tinyint 		</td><td>the hour of the event</td></tr>
<tr><td>mi 	      </td><td>tinyint 		</td><td>the minute of the event</td></tr>
<tr><td>ss		</td><td>tinyint		</td><td>the second of the event</td></tr>
<tr><td>logID	</td><td>int		</td><td>the log that this came from, foreign key: LogSource.logID</td></tr>
<tr><td>seq 	</td><td>bigint		</td><td>sequence number</td></tr>
<tr><td>clientIP 	</td><td>char(256)	</td><td>the IP address of the client</td></tr>
<tr><td>op 		</td><td>char(8)		</td><td>the operation (GET,POST,...) </td></tr>
<tr><td>command 	</td><td>varchar(7000)	</td><td>the command executed</td></tr>
<tr><td>error 	</td><td>int		</td><td>the error code if any</td></tr>
<tr><td>browser 	</td><td>varchar(2000)	</td><td>the browser type</td></tr>
<tr><td>location	</td><td>varchar(32)	</td><td>the location of the site (FNAL, JHU,..</td></tr>
<tr><td>service 	</td><td>varchar(32)	</td><td>type of service (SKYSERVER, SKYSERVICE, SKYQUERY,...)</td></tr>
<tr><td>instance	</td><td>varchar(32)	</td><td>The log underneath the service (V1, V2,.. ) </td></tr>
<tr><td>uri		</td><td>varchar(32)	</td><td>The url or other ID for this service. </td></tr>
<tr><td>framework </td><td>varchar(32)	</td><td>the calling framework (ASP,ASPX,HTML,QA,SOAP,...) </td></tr>
<tr><td>product	</td><td>varchar(32)	</td><td>the type of product acessed (EDR, DR1, DR2,... </td></tr>
<tr><td colspan=3>	PRIMARY KEY (yy desc ,mm desc,dd desc,hh desc,mi desc,ss  desc,seq desc,logID)</td></tr>
</table>


<h3>SqlLog Columns</h3>
<p>The (successfully or unsuccessfully) completed SQL queries. This information is actually written <br>
to the log DB on each SDSS server by the stored procedure that executes each SkyServer query.</p>
<table border=1>
<th>Name</th> <th>Type</th> <th>Description</th>
<tr><td>theTime		</td><td>datetime 	</td><td>the timestamp</td></tr>
<tr><td>webserver		</td><td>varchar(64) 	</td><td>the url</td></tr>
<tr><td>winname		</td><td>varchar(64) 	</td><td>the windows name of the server</td></tr>
<tr><td>clientIP		</td><td>varchar(16) 	</td><td>client IP address </td></tr>
<tr><td>seq			</td><td>int		</td><td>sequence number to guarantee uniqueness of PK</td></tr>
<tr><td>server		</td><td>varchar(32)	</td><td>the name of the database server</td></tr>
<tr><td>dbname		</td><td>varchar(32)	</td><td>the name of the database </td></tr>
<tr><td>access		</td><td>varchar(32)	</td><td>The website DR1, collab,...</td></tr>
<tr><td>sql 		</td><td>varchar(7800)	</td><td>the SQL statement</td></tr>
<tr><td>elapsed 		</td><td>real 		</td><td>the lapse time of the query</td></tr>
<tr><td>busy 		</td><td>real 		</td><td>the total CPU time of the query</td></tr>
<tr><td>[rows] 		</td><td>bigint 		</td><td>the number of rows generated</td></tr>
<tr><td>error		</td><td>int		</td><td>0 if ok, otherwise the sql error #; negative numbers are generated by the procedure</td></tr>
<tr><td>errorMessage	</td><td>varchar(2000)	</td><td>the error message.</td></tr>
<tr><td colspan=3>	PRIMARY KEY CLUSTERED (theTime,webserver,winname,clientIP,seq)</td></tr>
</table>

 


</div>


</body>
</html>

