<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "Sneekernet";
	string author ="William O'Mullane";
	string email ="womullan@jhu.edu";
	string cvsRevision = "$Revision: 1.3 $";
	
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("SkyHeader.aspx" + "?" + Parameters);
%>
<h1>Sneakernet</h2>
This is an old term for running across the hall with your floppy disk to transfer data. <br>
On SDSS we do this but using FEDEX and a full machine with a couple of TeraBytes onboard.
<!-- Your HTML or ASPX here --->
<h2>Where are they </h2>
<table border ="1">
	<tr>
		<td> Machine </td> <td> at </td> <td> Going to </td>
	</tr>
	<tr>
		<td> Sneeker1 </td> <td> JHU </td> <td> Japan </td>
	</tr>
	<tr>
		<td> Sneeker2 </td> <td> JHU </td> <td> Garching </td>
	</tr>
	<tr>
		<td> Sneeker3 </td> <td> JHU </td> <td> California </td>
	</tr>

</table>

<%	Server.Execute("SkyFooter.aspx" + "?" + Parameters);
%>
