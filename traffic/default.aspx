<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SDSS SkyServer Traffic Page";
	string cvsRevision = "$Revision: 1.12 $";
	Session["gselect"]=0;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>

<div id="transp">
<table width="600">
<tr><td>

	Yearly, monthly, daily traffic (UTC GMT time).
	Counts are summarized as hits to the entire site 
	and to the English, Japanese, German and the Projects 
	sub-branches. There are other service branches, which
	are outside the language subtrees, so the sum of the
	columns do not add up to the hits.
	<p>
	The traffic on the education project pages is also reported.
	The weblog can be analyzed with the 
	<a href="sql.asp">SQL Search Page</a> or the <a href="http://skyserver.sdss3.org/casjobs/">JHU CasJobs site.</a> 
	<p>

	
  <table width="600" border="0" >
	<tr><td>
<!-----------#include file="connection.js"-------------------->

  <%	
 	var Index = 0;
 	var count = 0;
 	var header = "<tr><td colspan=12 align='center' class='hsml'>";
	var c ="";
	var cmd = "select * from totalTraffic "; 
	oCmd.CommandText = cmd; 
	var oRs = oCmd.Execute(); 

	// table header 
	Response.Write("<table width='480' border='2'>\n");
		Response.Write("<tr align=center>");
		for(Index=0; Index <(oRs.fields.count); Index++) {
			Response.Write("<td  class='ssml'>" + oRs.fields(Index).name + "</td>");
        	}
		Response.Write("</tr>\n");




    // now display the total	

	count++;
	cmd = "select 'Total' as date, sum(hits) as hits, sum(English) as English, sum(German) as German,";
	cmd +=" sum(Hungarian) as Hungarian, sum(Japanese) as Japanese, sum(Spanish) as Spanish, sum(Portuguese) as Portuguese, sum(Project) as Project,";
	cmd += "sum(SkyServer) as SkyServer, sum(SkyService) as SkyService, sum(SQL) as SQL  from totalTraffic "; 
	oCmd.CommandText = cmd; 
	oRs = oCmd.Execute(); 
	while(!oRs.eof) {
		c = "<td class = " + ((count%2)==0?"'tsml'":"'bsml' ");
		Response.Write("<tr>"+ c + " align='left'>" + oRs.fields(0).Value + "</td>");
		for(Index=1; Index <(oRs.fields.count); Index++) {
			Response.Write(c + " align='right'>" + oRs.fields(Index).Value + "</td>");}
			Response.Write("</tr>\n");
			oRs.MoveNext(); 
			count++;
		}
    	oRs.close();	

	//Yearly totals
 	Response.Write(header+"Yearly</td></tr>");
	//

	count++;
	cmd = "select * from totalTraffic "; 
	oCmd.CommandText = cmd; 
	oRs = oCmd.Execute(); 
	while(!oRs.eof) {
		c = "<td class = " + ((count%2)==0?"'tsml'":"'bsml' ");
		Response.Write("<tr>"+ c + " align='left'>" + oRs.fields(0).Value + "</td>");
		for(Index=1; Index <(oRs.fields.count); Index++) {
			Response.Write(c + " align='right'>" + oRs.fields(Index).Value + "</td>");}
			Response.Write("</tr>\n");
			oRs.MoveNext(); 
			count++;
		}
    	oRs.close();


    //  Monthly totals
 	Response.Write(header+"Monthly (last 12 months)</td></tr>");
	// 	
	count++;
	cmd = "select top 12 * from monthlyTraffic order by month desc"; 
	oCmd.CommandText = cmd; 
	oRs = oCmd.Execute(); 
	while(!oRs.eof) {
		c = "<td class = " + ((count%2)==0?"'tsml'":"'bsml' ");
		Response.Write("<tr>"+ c + " align='left'>" + oRs.fields(0).Value + "</td>");
		for(Index=1; Index <(oRs.fields.count); Index++) {
			Response.Write(c + " align='right'>" + oRs.fields(Index).Value + "</td>");}
			Response.Write("</tr>\n");
			oRs.MoveNext(); 
			count++;
		}
    	oRs.close();

    // Most recent 30 days
 	Response.Write(header+"Daily (most recent 30)</td></tr>");

	cmd = "select top 30 * from DailyTraffic";
	oCmd.CommandText = cmd; 
	oRs = oCmd.Execute();	
	count++;	
	while(!oRs.eof) {
		c = "<td class = " + ((count%2)==0?"'tsml'":"'bsml' ");
		Response.Write("<tr>"+ c + " align='left'>" + oRs.fields(0).Value + "</td>");
		for(Index=1; Index <(oRs.fields.count); Index++) {
			Response.Write(c + " align='right'>" + oRs.fields(Index).Value + "</td>");}
			Response.Write("</tr>\n");		
			oRs.MoveNext(); 
			count++;
		} 
		oRs.close();

    // Highest traffic days
 	Response.Write(header+"High Traffic Days (most recent 30)</td></tr>");

	cmd = "select top 30 * from (select top 30 * from DailyTraffic";
	cmd += " order by hits desc) t order by t.date desc ";
	oCmd.CommandText = cmd; 
	oRs = oCmd.Execute();	
	count++;
		
	while(!oRs.eof) {
		c = "<td class = " + ((count%2)==0?"'tsml'":"'bsml' ");
		Response.Write("<tr>"+ c + " align='left'>" + oRs.fields(0).Value + "</td>");
		for(Index=1; Index <(oRs.fields.count); Index++) {
			Response.Write(c + " align='right'>" + oRs.fields(Index).Value + "</td>");}
			Response.Write("</tr>\n");		
			oRs.MoveNext(); 
			count++;
		} 
    	oRs.close();
    oConn.close();
    %>
    </tr>
	</table>
	<p>
</td></tr>
</table>
</div>

<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%><!-------#include file="../header.inc"--------->
<title></title>
<% var gselect=0; %>
