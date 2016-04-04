<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - Team";
	string cvsRevision = "$Revision: 1.15 $";
	string leftMenu = "gutter.aspx";
	string Parameters = "message="+Title+	"&"+"author="+author+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
  	Session["gselect"]=0;

%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%> 
<p>
The team behind the skyserver are multitalented and have various backgounds. You have seen
the names - here are the faces.
</p>
<table border=0> 
<tr>
<td valign=top>
<table >
<tr> <td><a href="pici.aspx?pic=tamas.jpg&cap=Tamas Budavari&gselect=1"> Tamas Budavari </a></td><td><a href="pici.aspx?pic=tamas.jpg&cap=Tamas Budavari&gselect=1"><img src="Ttamas.jpg" width="53" height="70"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=george.jpg&cap=George Fekete&gselect=13"> George Fekete </a></td><td><a href="pici.aspx?pic=george.jpg&cap=George Fekete&gselect=13"><img src="Tgeorge.jpg" width="90" height="72"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=sam.jpg&cap=Samuel Lee Carliles&gselect=3"> Sam Carliles </a></td><td><a href="pici.aspx?pic=sam.jpg&cap=Samuel Lee Carliles&gselect=3"><img src="Tsam.jpg" width="53" height="70"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=nolan.jpg&cap=Nolan Li&gselect=4"> Nolan Li </a></td><td><a href="pici.aspx?pic=nolan.jpg&cap=Nolan Li&gselect=4"><img src="Tnolan.jpg" width="53" height="70"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=maria.jpg&cap=Maria Nieto-Santisteban&gselect=5"> Maria Nieto-Santisteban </a></td><td><a href="pici.aspx?pic=maria.jpg&cap=Maria Nieto-Santisteban&gselect=5"><img src="Tmaria.jpg" width="53" height="70"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=tanu.jpg&cap=Tanu Malik&gslect=6"> Tanu Malik</a> </td><td><a href="pici.aspx?pic=tanu.jpg&cap=Tanu Malik&gslect=6"><img src="Ttanu.jpg" width="53" height="70"></a> </td></tr>
</table>
</td><td valign=top>

<table >
<tr> <td><a href="pici.aspx?pic=wil.jpg&cap=William O'Mullane&gselect=7"> William O'Mullane</a> </td><td><a href="pici.aspx?pic=wil.jpg&cap=William O'Mullane&gselect=7"><img src="Twil.jpg" width="90" height="68"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=adrian.jpg&cap=Adrian Pope&gselect=8"> Adrian Pope </a></td><td><a href="pici.aspx?pic=adrian.jpg&cap=Adrian Pope&gselect=8"><img src="Tadrian.jpg" width="90" height="68"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=jordan.jpg&cap=Jordan Raddick&gselect=9"> Jordan Raddick </a></td><td><a href="pici.aspx?pic=jordan.jpg&cap=Jordan Raddick&gselect=9"><img src="Tjordan.jpg" width="53" height="70"></a> </td></tr>
<tr><td> <a href="pici.aspx?pic=alex.jpg&cap=Alex Szalay&gselect=10"> Alex Szalay  </a> </td><td> <a href="pici.aspx?pic=alex.jpg&cap=Alex Szalay&gselect=10"><img src="Talex.jpg" width="90" height="68"> </td></tr>
<tr> <td><a href="pici.aspx?pic=ani.jpg&cap=Ani Thakar&gselect=11"> Ani Thakar </a></td><td><a href="pici.aspx?pic=ani.jpg&cap=Ani Thakar&gselect=11"><img src="Tani.jpg" width="53" height="70"></a> </td></tr>
<tr> <td><a href="pici.aspx?pic=jan.jpg&cap=Jan van den Berg&gselect=12"> Jan van den Berg </a></td><td><a href="pici.aspx?pic=jan.jpg&cap=Jan van den Berg&gselect=12"><img src="Tjan.jpg" width="90" height="68"></a> </td></tr>
</table>

</td></tr>
</table>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);%>