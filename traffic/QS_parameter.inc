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
			<u>Please see the </u><a href="<%=url%>/help/docs/limits.asp"><u>Query Limits
			help page</u></a><u> for <b>timeouts</b> and <b>row limits</b>.
			<a href="<%=userguide%>#DASfilters"><u>To get FITS files</u></a><u> from<br> the </u><a href="http://www.sdss.org/<%=release%>"><u>Data Archive Server (DAS)</u></a><u>, save results to CSV file 
			and upload it to </u><a href="http://das.sdss.org/<%=release%>-cgi-bin/DAS"><u>DAS retrieval form</u></a>
		  </td></tr>
		</table>
<%
function showImgParams( cmd, oRs, type ) {
	cmd = "SELECT [name] FROM DBColumns WHERE tableName='PhotoObjAll'";
	oCmd.CommandText = cmd;
	Response.Write("<td class='q' width='100'>");
	oRs = oCmd.Execute();
	if (oRs.eof) {
		Response.Write("<b>No columns found for table PhotoObjAll</b>\n");
	} else {
		Response.Write("\t<SELECT name=\"imgparams\" multiple=\"multiple+\" size=\"5\">\n");
		if( type == "spec" ) {
			Response.Write("\t\t<OPTION value=\"none\" selected>none</OPTION>\n");
			Response.Write("\t\t<OPTION value=\"minimal\">minimal</OPTION>\n");
		} else
			Response.Write("\t\t<OPTION value=\"minimal\" selected>minimal</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"typical\">typical</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"radec\">radec</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"model_mags\">model_mags</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"model_magerrs\">model_magerrs</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"psf_mags\">psf_mags</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"psf_magerrs\">psf_magerrs</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"petro_mags\">petro_mags</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"petro_magerrs\">petro_magerrs</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"model_colors\">model_colors</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"ugModelColor\">ugModelColor</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"grModelColor\">grModelColor</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"riModelColor\">riModelColor</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"izModelColor\">izModelColor</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"SDSSname\">SDSSname</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"blankImg\"> </OPTION>\n");
		while(!oRs.eof) {
			Response.Write("\t\t<OPTION value=\""+oRs.fields(0).value+"\">"+oRs.fields(0).value+"\n");
			oRs.MoveNext();
		}
		Response.Write("\t</OPTION></SELECT>\n");
		Response.Write("</td><td class='q' rowspan=2><input type=radio name=dataset value=targdb>");
		Response.Write("TARGET Imaging<p><input type=radio name=dataset value=bestdb checked>");
		Response.Write("BEST Imaging");
	}
	Response.Write("</td>\n");
	oRs.close();
}

function showSpecParams( cmd, oRs, type ) {
	cmd = "SELECT [name] FROM DBColumns WHERE tableName='SpecObjAll'";
	oCmd.CommandText = cmd;
	oRs = oCmd.Execute();	
	Response.Write("<td class='q' width='100'>");
	if (oRs.eof) {
		Response.Write("<b>No columns found for table SpecObjAll</b>\n");
	} else {
		Response.Write("\t<SELECT name=\"specparams\" multiple=\"multiple\" size=\"5\">\n");
		if( type == "spec" )
			Response.Write("\t\t<OPTION value=\"minimal\" selected>minimal</OPTION>\n");
		else {
			Response.Write("\t\t<OPTION value=\"none\" selected>none</OPTION>\n");
			Response.Write("\t\t<OPTION value=\"minimal\">minimal</OPTION>\n");
		}
		Response.Write("\t\t<OPTION value=\"typical\">typical</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"radec\">radec</OPTION>\n");
		Response.Write("\t\t<OPTION value=\"blankSpec\"> </OPTION>\n");
		while(!oRs.eof) {
			Response.Write("\t\t<OPTION value=\""+oRs.fields(0).value+"\">"+oRs.fields(0).value+"\n");
			oRs.MoveNext();
		}
		Response.Write("\t</OPTION></SELECT>\n");
	}
	oRs.close();
	Response.Write("</td>\n");
}
%>

<table cellspacing='3' cellpadding='3' class='frame' width=640>
<tr><td align=middle >
		<a class='qtitle' href="<%=userguide%>#Parameters" 
			title="Parameters to return from your query">Parameters to return</a></td>
</tr>
<%
	var first, second, span1, span2, firstTab, secondTab;
	if( queryType == "spec" ) {
		first = "Spectroscopy";
		firstTab = "SpecObj";
		span1=1;
		span2=2;
		second = "Imaging";
		secondTab = "PhotoObj";
	} else {
		first = "Imaging";
		firstTab = "PhotoObj";
		span1=2;
		span2=1;
		second = "Spectroscopy";
		secondTab = "SpecObj";
	}
%>
<tr><td>

  <table border=0 cellpadding=4 cellspacing=4 width=100%>
  <tr><td colspan=4 align=middle class='q'><table><tr>
	<td class=smallbodytext>
		(<b>Shift-mouse</b> to select multiple <b>contiguous</b> entries, <b>Ctrl-mouse</b> to select <b>non-contiguous</b> entries)</td>
	</tr></table></td>
  </tr><tr>
	<td class='q' colspan='<%=span1%>' align='middle'>
		<a href="<%=url%>/help/browser/description.asp?n=<%=firstTab%>&t=U" 
		title="<%=first%> parameters to return from your query"><%=first%></a></td>
	<td class='q' colspan='<%=span2%>' align='middle'><a href="<%=url%>/help/browser/description.asp?n=<%=secondTab%>&t=U" 
		title="<%=second%> parameters to return from your query">
		<%=second%></a></td>
	<td class='q'><a href="<%=userguide%>#DASfilters" 
		title="Filters to feed to a subsequent DAS webform query">
		Filter (for DAS use)</a> </td>
  </tr>
  <tr>
<%
	var cmd;
	var oRs;
	if( queryType == "spec" ) {
		showSpecParams( cmd, oRs, queryType );
		showImgParams( cmd, oRs, queryType );
	} else {
		showImgParams( cmd, oRs, queryType );
		showSpecParams( cmd, oRs, queryType );
	}
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