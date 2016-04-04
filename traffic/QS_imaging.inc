<table cellspacing='3' cellpadding='3' class='frame' width='640'>
<!-------------------------------------------------------------------------------->
  <tr><td align=middle>
	<a class='qtitle' href=<%=userguide%>#ImagingConstraints 
		title="Apply constraints based on imaging data on the objects returned by the query">
		Imaging Constraints</a>
  </td></tr>
<!-------------------------------------------------------------------------------->
  <tr><td>
    <table cellpadding=4 cellspacing=4 width=100%>
	<tr>	
	  <td colspan=7 class='q'>
		<table width=100%>
		  <tr>
			<td>Magnitude and Color Type</td>
			<td>
				<input type=radio name=magType value=petro>
				<a href=<%=userguide%>#MagnitudeType 
					title="Use petrosian magnitudes and colors to constrain query">Petro</a>
			</td>
			<td>		
				<input type=radio name=magType value=model checked>
				<a href=<%=userguide%>#MagnitudeType 
					title="Use model magnitudes and colors to constrain query">Model</a> 
			</td>
			<td>		
				<input type=radio name=magType value=psf>
				<a href=<%=userguide%>#MagnitudeType 
					title="Use PSF magnitudes and colors to constrain query">PSF</a>
			</td>
		  </tr>
		</table>
	  </td>
	</tr>
<!-------------------------------------------------------------------------------->
	<tr><td class='q' width=80 rowspan=2 ><a href=<%=userguide%>#Magnitudes title="Apply constraints based on the magnitude">Magnitudes</a></td>
		<td class='q' width=25>min</td>
		<td class='q' width=95><table width=100%><tr><td>u</td><td align=right><input class='mag' type=text name=uMin size=2></td></tr></table></td>
		<td class='q' width=95><table width=100%><tr><td>g</td><td align=right><input class='mag' type=text name=gMin size=2></td></tr></table></td>
		<td class='q' width=95><table width=100%><tr><td>r</td><td align=right><input class='mag' type=text name=rMin size=2></td></tr></table></td>
		<td class='q' width=95><table width=100%><tr><td>i</td><td align=right><input class='mag' type=text name=iMin size=2></td></tr></table></td>
		<td class='q' width=95><table width=100%><tr><td>z</td><td align=right><input class='mag' type=text name=zMin size=2></td></tr></table></td>
	</tr>
	<tr>
		<td class='q'>max</td>
		<td class='q'><table width=100%><tr><td>u</td><td align=right><input class='mag' type=text name=uMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>g</td><td align=right><input class='mag' type=text name=gMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>r</td><td align=right><input class='mag' type=text name=rMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>i</td><td align=right><input class='mag' type=text name=iMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>z</td><td align=right><input class='mag' type=text name=zMax size=2></td></tr></table></td>
	</tr>
	<tr>
		<td class='q' rowspan=2><a href=<%=userguide%>#Colors title="Apply constraints based on the colors">Colors</a></td>
		<td class='q'>min</td>
		<td class='q'><table width=100%><tr><td>u-g</td><td align=right><input class='mag' type=text name=ugMin size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>g-r</td><td align=right><input class='mag' type=text name=grMin size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>r-i</td><td align=right><input class='mag' type=text name=riMin size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>i-z</td><td align=right><input class='mag' type=text name=izMin size=2></td></tr></table></td>
		<td class='q'>&nbsp;</td>
	</tr>
	<tr>
		<td class='q'>max</td>
		<td class='q'><table width=100%><tr><td>u-g</td><td align=right><input class='mag' type=text name=ugMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>g-r</td><td align=right><input class='mag' type=text name=grMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>r-i</td><td align=right><input class='mag' type=text name=riMax size=2></td></tr></table></td>
		<td class='q'><table width=100%><tr><td>i-z</td><td align=right><input class='mag' type=text name=izMax size=2></td></tr></table></td>
		<td class='q'>&nbsp;</td>
	</tr>
<!-------------------------------------------------------------------------------->
	<tr>
		<td class='q'><a href=<%=userguide%>#ObjectType title="Apply constraints based on the imaging-classified object type">Obj Type</a></td>
		<td class='q' colspan='6'>
		  <table width=365>
			<tr>
				<td><input type=checkbox name=doGalaxy checked>Extended Sources <i>(e.g., Galaxies)</i></td>
				<td><input type=checkbox name=doSky>Sky</td>
			</tr>
			<tr>
				<td><input type=checkbox name=doStar checked>Point Sources <i>(e.g., Stars)</i></td>
				<td><input type=checkbox name=doUnknown>Unknown</td>
			</tr>
		</table>
		</td>
	</tr>
<!-------------------------------------------------------------------------------->
<%		
	Response.Write("<tr class='q'><td colspan=8 align=center class=smallbodytext>");
	Response.Write(" (<b>Shift-mouse</b> to select multiple <b>contiguous</b> entries, <b>Ctrl-mouse</b>");
	Response.Write(" to select <b>non-contiguous</b> entries)</td></tr>");
%>
	<tr>
		<td class='q' rowspan=2><a href=<%=userguide%>#objFlags 
			title="Apply constraints based on the first set of flags">Obj Flags</a>
		</td>
		<td class='q' colspan=6>
		  <table>
			<tr>
<%
	cmd = "SELECT [name] FROM DataConstants WHERE field='PhotoFlags' ORDER BY value";
	oCmd.CommandText = cmd;
	oRs = oCmd.Execute();	
	if (oRs.eof) {
		Response.Write("<td><b>No PhotoFlags found in DataConstants table</b></td>\n");
	} else {
		Response.Write("<td><strong>At least one of these ON</strong></td>\n");
		Response.Write("<td width=20>&nbsp;</td>\n");
		Response.Write("<td><strong>All of these OFF</strong><br></td></tr>\n");
		Response.Write("\t<tr>\n\t\t<td><SELECT name=\"flagsOnList\" multiple=\"multiple+\" size=\"5\">\n");
		Response.Write("\t\t<OPTION value=\"ignore\" selected>ignore</OPTION>\n");
		while(!oRs.eof) {
			Response.Write("\t\t<OPTION value=\""+oRs.fields(0).value+"\">"+oRs.fields(0).value+"\n");
			oRs.MoveNext();
		}
		Response.Write("\t</OPTION></SELECT></td><td>&nbsp;</td>\n");
		oRs.close();

		oRs.open();	
		Response.Write("\t\t<td><SELECT name=\"flagsOffList\" multiple=\"multiple+\" size=\"5\">\n");
		Response.Write("\t\t<OPTION value=\"ignore\" selected>ignore</OPTION>\n");
		while(!oRs.eof) {
			Response.Write("\t\t<OPTION value=\""+oRs.fields(0).value+"\">"+oRs.fields(0).value+"\n");
			oRs.MoveNext();
		}
		Response.Write("\t</OPTION></SELECT></td>\n");
	}
	oRs.close();
%>
			</tr>
		  </table>
		</td>
	</tr>
<!-------------------------------------------------------------------------------->
	</table>
  </td></tr>

</table>

<p>
<input id=submit type="submit" value="Submit Request">
<input id=reset  type="reset" value="Reset Form">
<p>
