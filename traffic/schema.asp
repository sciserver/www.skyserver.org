<!-------#include file="../header.inc"--------->
<title>SDSS SkyServer</title>
<% var gselect=0;%>
<!-------#include file="../banner.inc"---------->
<!-------#include file="gutter.inc"------------->
<!-----------display basic traffic table-------------->
</head>
<body>
	<div id="title">Advanced Searches</div>
	<div id="transp">
		<table width="600" ID="Table1">
			<tr>
				<td>
					<H1>SkyServer Common Log</H1>
					<p>
					<p>
						SkyServer, SkyService, and SkyQuery nodes around the world are generating logs 
						of their traffic activity. SdssQA and the CASjobs system are also keeping 
						activity logs. These logs record the web traffic and SQL queries. They provide 
						insight into how the systems are used, their performance, and their problems. 
						Information distilled from the weblogs is a very crucial part of the annual 
						reports to funding agencies and gives us a sense of what is being used.</p>
					<p>
						We harvest these logs and consolidate them into a single global SdssAd2.weblog 
						database at JHU. A summary of it is available at the <a href="../traffic/"> Web Site Traffic</a> 
						page and it may be queried via the <a href="http://skyserver.sdss.org/dr1/en/tools/search/sql.asp"> Search tool</a> with sql 
						statements like:</p>
					<ul>
						<li>
							<p><b><FONT face="Courier New">Select count(*) from SdssAd2.weblog.dbo.weblog</FONT></b></p>
						</li>
						<li>
							<p><b><FONT face="Courier New">Select top 100 * from SdssAd2.weblog.dbo.sqllog</FONT></b></p>
						</li>
					</ul>
					<p>
						Privacy is a big concern. There is no easy way to trace IP addresses back to 
						individuals – indeed individual IP addresses generally vary from one session to 
						the next. But, still the SDSS collaboration wants to keep its data and its data 
						queries private. So, all the /collab/ traffic is gathered in the WebLogAll and 
						SqlLogAll tables and contributes to aggregate statistics; but, detailed collab 
						and CAS job records are hidden from the public. The public is shown the WebLog 
						and SqlLog views that only contain log records from the public SkyServers.
					</p>
					<p>
						At present there are two kinds of logs:</p>
					<ol>
						<li>
							<b>Web logs</b>
						that record requests to web servers (IIS) doing either HTTP or SOAP requests, 
						and
						<li>
							<b>SQL logs</b> recording SQL requests to SQL servers.
						</li>
					</ol>
					<p>
						Each log source is described as a record in the LogSource table. A particular 
						log has the dimensions:<o:p></o:p></SPAN></p>
					<OL>
						<LI>
							<b>Location:</b>
						The place where the server resides (FermiLab, JHU, …)
						<LI>
							<b>Service:</b>
						The kind of service being provided (SkyServer, SkyService, SkyQuery, SQL,…)
						<LI>
							<b>Instance:</b> The particular server providing this service 
							(SdssAd6,SkyServer.pha.jhu.edu,..)</LI></OL>
					<p>
						It also has dimensions that tell how to fetch the log and when it was last 
						fetched. Each log source also has a unique LogID that is used as a <i>foreign key</i>
						in the actual log instance records. All these attributes are recorded in the 
						LogSource table.</p>
					<p>
						The logs are pulled from the <i>active</i> data sources either locally with 
						file copy and bcp; or, they are gathered over the web. We have not yet 
						implemented the web harvesting. The actual copy operation is driven by reading 
						the LogSource table and executing the “data pull” into the common database. The 
						logic is simple:</p>
					<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
						<p><FONT face="Courier New">For each pull type</FONT></p>
						<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
							<p><FONT face="Courier New">For each source of that type </FONT>
							</p>
							<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
								<p><FONT face="Courier New">Pull the recent records to a local temporary table</FONT></p>
								<p><FONT face="Courier New">Reformat it to the local format</FONT></p>
								<p><FONT face="Courier New">Add it to the local log</FONT></p>
							</BLOCKQUOTE></BLOCKQUOTE>
						<p><FONT face="Courier New">Update the recent traffic statistics</FONT></p>
					</BLOCKQUOTE>
					<p>
						A SQL agent on the WebLog machine executes this logic once an hour.
					</p>
					<p>
						WebLog and SqlLog are public views of the webLogAll and SqlLogAll tables. They 
						join the tables with selected fields of the LogSource table to give more 
						information about what site generated the log traffic.</p>
					<p></p>						
				</td>				
			</tr>
			<tr>
			<td align=center><img src=../img/log-tables.jpg border=0></a></td>
			</tr>
		</table>
	</div>
</body>
</html>
