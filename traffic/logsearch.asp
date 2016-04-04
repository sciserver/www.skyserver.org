<!-------#include file="../header.inc"--------->
<title>SDSS Weblog Query Form</title>
<% var gselect=0;%>
<!-------#include file="../banner.inc"---------->
<!-------#include file="gutter.inc"------------->
</head>
<body>
<style>
	td,p	{font-size:10pt; color:#000000}
	.tiny	{font-size:8pt; color:#000000}
	.qtitle {font-size:12pt;color:#ffffff;font-weight:bold;}
	.q		{background-color:#dddddd}
	.frame	{background-color:#888888;}
	a		{color:#000088;font-weight:normal;}
	.pos	{width:66px}
	.mag	{width:56px}
	.name	{width:200px}
	.txt	{width:260px}
</style>

<div id="title">Weblog Query Form</div>
<div id="transp">
<table width="600">
<tr><td>
<form method="post" enctype="multipart/form-data" action="x_logsearch.asp" id=logqry name="logqry">

<!-------#include file="../../connection.js"-------->
<table border=1 cellspacing=3 cellpadding=3 bgcolor=#aaaaaa>
<tr><td>
<p>
<input id=submit type="submit" value="Submit Request">
<input id=reset  type="reset" value="Reset Form">
&nbsp;&nbsp;Limit number of output rows (0 for unlimited) to 
		<input type=text name="limit" size=5 value="50"><br>
		<table BORDER=0 WIDTH="100%" >
		  <tr class='q'>
			<td ALIGN=left width="20%">Output Format</td>
			<td width="30%" ALIGN=middle><input name=format value="html" type=radio class="box" CHECKED>HTML</td>
			<td width="30%" ALIGN=middle><input name=format value="xml"  type=radio class="box">XML</td>
			<td width="30%" ALIGN=middle><input name=format value="csv"  type=radio class="box">CSV</td>
		  </tr>
		  <tr><td align=center colspan=4>
		  </td></tr>
		</table>
<%
function showWeblogParams( cmd, oRs ) {
	cmd = "SELECT logID,location,service,instance,uri,product FROM sdssad2.weblog.dbo.logsource ";
	cmd += "WHERE status='ACTIVE' AND isvisible=1";
	oCmd.CommandText = cmd;
	Response.Write("<td class='q' width='100'>");
	oRs = oCmd.Execute();
	if (oRs.eof) {
		Response.Write("<b>Cannot retrieve log source table from log server.</b>\n");
	} else {
		while(!oRs.eof) {
			Response.Write("\t\t<OPTION value=\""+oRs.fields(0).value+"\">"+oRs.fields(0).value+"\n");
			oRs.MoveNext();
		}
	}
	Response.Write("</td>\n");
	oRs.close();
}
%>

<table cellspacing='3' cellpadding='3' class='frame' width=640>
<tr><td align=middle >
		<a class='qtitle'	title="Parameters to return from your query">Parameters to return</a></td>
</tr>
<tr><td>

  <table border=0 cellpadding=4 cellspacing=4 width=100%>
  <tr><td colspan=4 align=middle class='q'><table><tr>
	<td class=smallbodytext>
		(<b>Shift-mouse</b> to select multiple <b>contiguous</b> entries, <b>Ctrl-mouse</b> to select <b>non-contiguous</b> entries)</td>
	</tr></table></td>
  </tr><tr>
	<td class='q' colspan='2' align='middle'>Parameters to return</td>
  </tr>
  <tr>
<%
	var cmd;
	var oRs;
	showWeblogParams( cmd, oRs );
%>
	<td class='q'>
		u<input type=checkbox name=uFilter checked>
		g<input type=checkbox name=gFilter>
		r<input type=checkbox name=rFilter>
		i<input type=checkbox name=iFilter>
		z<input type=checkbox name=zFilter>
	</td>
  </tr>
  </table>
</td></tr></table>

<p>
<input id=submit type="submit" value="Submit Request">
<input id=reset  type="reset" value="Reset Form">
<p>
</td></tr>
</table>
<!----------------------------------------------------->
</form>
</div>
</body>
</html>
