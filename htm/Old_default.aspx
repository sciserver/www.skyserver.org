<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - HTM Legacy Version";
	string cvsRevision = "$Revision: 1.1 $";
	string leftMenu = "gutter.aspx";
    /* author = "Gyorgy Fekete"; */
	string Parameters = "message="+Title+	"&"+"author="+author+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
  	Session["gselect"]=0;

%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>
<IMG SRC = "../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
Hierarchical Triangular Mesh*</h1>
<hr>
<br>

<dl>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#desc">
Description
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "doc/">
Documentation / Papers
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "implementation.aspx">
Implementations / Download
</A>
<BR>
</dl>
<p class="small">*This project is supported by a grant from the NASA AISRP Program.</p>
<hr>
<ul>

The Hierarchical Triangular Mesh is the indexing concept used in the
SDSS Science Archive to partition the data by location on the
celestial sphere. 

Astronomical data are naturally laid out on a sphere since all objects
have a coordinate to start with. Databases usually split up their data
to cluster objects that are in the same region of the sky. However,
the task of splitting the surface of the sphere into regions turns out
to be a little tricky. People have come up with several schemes how to
deal with it, most of them have problems at the poles or deal with
complicated projection geometry.

<p>
The HTM is a simple and elegant way to circumvent this problem. It
does not involve any singularities or deal with projections. Our
implementation is fast enough that computational cost is kept at its
minimum.

<p>
We would like to encourage everyone dealing with spherically indexed
data to use the HTM since it is also a great tool to do cross-matching
between databases. The <a
href="implementation..aspx">implementation</a> used in the SX is
available to download in C, C++ and Java. A seperate download is
available for SQL Server which gives access to HTM funcitons
 inside SQL.


<a name="desc"></a>
<h3>Description</h3>

<p>
The Hierarchical Triangular Mesh (HTM) is a partitioning scheme to
divide the surface of the unit sphere into spherical triangles. It is
a hierarchical scheme and the subdivisions have not exactly, but
roughly equal areas.

<p>
The subdivision starts with the 8 largest equal-sized spherical
triangles: the octahedron on the sphere. These are subdivided
into 4 triangles by connecting the side-midpoints of neighboring
sides. The subdivision may be continued to any level; below we 
show subdivisions up to level 5.

<center>
<img src="../images/htm/l0.gif" width="200" height="200">
<img src="../images/htm/l1.gif" width="200" height="200">
<img src="../images/htm/l2.gif" width="200" height="200"><br>
<img src="../images/htm/l3.gif" width="200" height="200">
<img src="../images/htm/l4.gif" width="200" height="200">
<img src="../images/htm/l5.gif" width="200" height="200">
<br>
Subdividing the sphere, all triangles planar for simplicity.<br>
Triangle sides are always great circle segments.
</center>


<P>The HTM is stored as a quad-tree, the 8 root triangles are named
N0, N1, N2, N3 and S0, S1, S2, S3.  Each node has 4 children, labeled
0-3. In the SX, the database names are the node names at level 5, for
example <bold>N201301</bold>. <bold>N2</bold> is the root name, then
we have 5 digits (01301) denoting which triangle to choose at each level.

<center>
<table BORDER=0 CELLSPACING=10 >
<tr>
<td VALIGN=TOP>
<img SRC="../images/htm/north.jpg" width="240" height="264" >
<td VALIGN=TOP>
<img SRC="../images/htm/space.jpg" width="240" height="32" ><br><img SRC="../images/htm/south.jpg" width="235" height="272" ></td>
</tr>
</table>
<br>
<img SRC="../images/htm/triangles.jpg" width="443" height="263">
<br><br>
The starting 8 nodes and the subdivision scheme.
</center>
<br>

<p>
Further details on how the subdivision is actually performed, querying, cross-matching and statistics can be found in
the <a href="doc/">documentation</a>.
<p> the folowing table gives an indication of pixel area and number of htm leaves in HTMs of given depths. Pixel areas are not equal so the given number is nominal.
<br>
<table border=1>
<tr><Td >Level</td><td>Area (arcmin^2)</td><td> Num Leaves </td> </tr>
<tr> <td>10</td> <td>1.77E1</td> <td>8,388,608 </td> </tr>
<tr> <td>11</td> <td>4.43E0</td> <td>33,554,432</td> </tr>
<tr> <td>12</td> <td>1.11E0</td> <td>134,217,728 </td></tr>
<tr> <td>13</td> <td>2.77E-1</td> <td>536,870,912 </td></tr>
<tr> <td>14</td> <td>6.92E-2</td> <td>2,147,483,648</td> </tr>
<tr> <td>15</td> <td>1.73E-2</td> <td>8,589,934,592</td> </tr>
<tr> <td>20</td> <td>1.69E-5</td> <td>8,796,093,022,208</td></tr>
<tr> <td>25</td> <td>1.65E-8</td> <td>9,007,199,254,740,922</td></tr>
</table>
</ul>


<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);%>
