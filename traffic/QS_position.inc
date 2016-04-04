<table cellspacing='3' cellpadding='3' width=640 class='frame'>
<tr><td align=middle >
		<a class='qtitle' href="<%=userguide%>#PositionConstraint" 
			title="Apply positional constraints on the objects returned by the query">
		Position Constraints</a></td>
</tr>
<tr><td>

  <table border=0 cellpadding=4 cellspacing=4 width=100%>
  <tr>
	<td rowspan='2' class='q'> 
		<table><tr>
		<td><input type=radio name=positionType value=rectangular></td>
		<td><a href=<%=userguide%>#PositionRectangularConstraint 
			title="Search a rectangular area bounded in RA and Dec.">Rectangle</a></td>
		</tr></table>
	</td>
	<td class='q' width=40>min</td>
	<td class='q' width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionRectangularConstraint 
				title="FORMAT:  D.ddddd, HH:MM:SS.ss, or HH MM SS.ss (J2000)">ra</a></td>
			<td align=right><input class='pos' type=text name=raMin size=3></td>
		</tr></table>
	</td>
	<td class='q' width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionRectangularConstraint 
				title="FORMAT:  sD.ddddd, sDD:MM:SS.ss, or sDD MM SS.ss (J2000)">dec</a></td>
			<td align=right><input class='pos' type=text name=decMin size=3></td>
		</tr></table>
	</td>
	<td class='q' rowspan='2'>
		&nbsp;&nbsp;&nbsp;<i>(max 10 square degrees)</i>
	</td>
  </tr>
  <tr>
	<td class='q'>max</td>
	<td class='q'  width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionRectangularConstraint 
				title="FORMAT:  D.ddddd, HH:MM:SS.ss, or HH MM SS.ss (J2000)">ra</a></td>
			<td align=right><input class='pos' type=text name=raMax size=3></td>
		</tr></table>
	</td>
	<td class='q' width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionRectangularConstraint 
				title="FORMAT:  sD.ddddd, sDD:MM:SS.ss, or sDD MM SS.ss (J2000)">dec</a></td>
			<td align=right><input class='pos' type=text name=decMax size=3></td>
		</tr></table>
	</td>
</tr>

<tr>
	<td class='q'> 
		<table><tr>
			<td><input type=radio name=positionType value=cone checked></td>
			<td><a href=<%=userguide%>#PositionConeConstraint 
				title="Search within a given radius of a position">Cone</a></td>
		</tr></table>
	</td>
	<td class='q'>center</td>
	<td class='q' width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionConeConstraint 
				title="FORMAT:  D.ddddd, HH:MM:SS.ss, or HH MM SS.ss (J2000)">ra</a></td>
			<td align=right><input class='pos' type=text name=raCenter  size=3 value=180.0></td>
		</tr></table>
	</td>
		
	<td class='q' width=100>
		<table width=100%><tr>
			<td width='45'><a href=<%=userguide%>#PositionConeConstraint 
				title="FORMAT:  sD.ddddd, sDD:MM:SS.ss, or sDD MM SS.ss (J2000)">dec</a></td>
			<td align=right><input class='pos' type=text name=decCenter size=3 value=0.2></td>
		</tr></table>
	</td>
	<td class='q'>
		<table><tr>
			<td><a href=<%=userguide%>#PositionConeConstraint 
				title="FORMAT:  M.mmm (arcmin)">radius</a></td>
			<td><input type=text name=radius size=2 value=5.0>&nbsp;&nbsp;arcmin &nbsp;<i>(max 30')</i></td>
		</tr></table>
</tr>
<tr> 
	<td class='q'>
		<table><tr>
			<td><input type=radio name=positionType value=proximity></td>
			<td><a href=<%=userguide%>#PositionProximityConstraint 
				title="Search near a set of positions">Proximity</a></td>
		</tr></table>
	</td>
	<td class='q' colspan=3>
		List of <a href=<%=userguide%>#PositionProximityConstraint 
			title="FORMAT:  D.ddddd, HH:MM:SS.ss, or HH MM SS.ss (J2000)">ra</a>,
			<a href=<%=userguide%>#PositionProximityConstraint 
			title="FORMAT:  sD.ddddd, sDD:MM:SS.ss, or sDD MM SS.ss (J2000)">dec</a>[,
			<a href=<%=userguide%>#PositionProximityConstraint 
			title="FORMAT:  S.ss (arcsec)">radius</a>]<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(max 100 obj)</i><br> 
	<textarea class='txt' name=radecTextarea rows=4 cols=22>ra,dec,sep
256.443154,58.0255,10.
29.94136,0.08930,10.
</textarea>
	</td>
	<td class='q'>
		<table><tr>
			<td>radius</td>
			<td><input type=text size=2 name=radiusDefaultArcsec value=5.0>&nbsp;arcsec&nbsp;<i>(max 10")</i></td>
		</tr></table>
		<br>&nbsp;Upload File<br><input class='name' size=9 type=file name=radecFilename>&nbsp;  
	</td>
  </tr>
  <tr>
	<td rowspan='2' class='q'> 
		<table><tr>
		<td><input type=radio name=positionType value=none></td>
		<td><a href=<%=userguide%>#NoPositionConstraint 
			title="No Position Constraint">None</a></td>
		</tr></table>
	</td>
	<td colspan='3' class='q'><i><b>No position constraint</b></i></td>
  </tr>
  </table>

</td></tr></table>

<p>
<input id=submit type="submit" value="Submit Request">
<input id=reset  type="reset" value="Reset Form">
<p>
