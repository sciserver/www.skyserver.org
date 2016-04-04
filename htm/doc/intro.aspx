<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string author ="William O'Mullane";
	string email ="womullan.edu";
	string cvsRevision = "$Revision: 1.4 $";
	Session["gselect"]="1.1";
	string Parameters = "message="+Title+	"&"+"author="+author+ "&leftMenu=../gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>
<IMG SRC = "../../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
Introduction</h1>
<hr>
<br><br>

<table>
<tr>
<td><center>Prev</center></td>
<td><center><a href="constr.aspx">Next</a></center></td>
<td><center><a href="default.aspx#online">Contents</a></center></td>
</tr>
</table>

<hr>
<br><br>

There are several domains in science where we face the problem of
cataloguing and scanning through objects by object location in
3-dimensional space. In Astronomy and Earth Sciences, the coordinate
system is usually spherical, so the object's coordinate is given by its
localization on the surface of the unit sphere and its distance from the
origin.  When catalogs of objects are created, user queries mostly
involve queries on these coordinates, defining areas on the unit
sphere, often using complicated spherical trigonometrics.

<p>
There is a great interest to define a universal, computer-friendly
index on the sphere, especially in Astronomy, where the ancient
'index' of stellar constellations is still in common use. The 
index we present here conveniently maps regions of the sphere to
unique identifying names, that can be used by itself as a
reference. The mapping uses only elementary spherical geometry to
identify a certain area.  This provides universality, which is essential
for cross-referencing across different datasets.

<p>
We call the scheme presented here Hierarchical Triangular Mesh (HTM).
This technique to subdivide the sphere into spherical triangles
presented here is a recursive process. At each level of recursion the
area of the triangles is roughly the same, which is a major advantage
over the usual spherical coordinate system subdivisions where we have
to deal with different cell sizes and singularities around the
poles. Also, in areas with high data density, the recursion process
can be applied to a higher level than in areas where data points are
rare. This enables us to structure uneven data distributions into
equal-sized bins.

<a name="figure1"></a>
<center>
<img src="../../images/htm/l0.gif" width="200" height="200">
<img src="../../images/htm/l1.gif" width="200" height="200">
<img src="../../images/htm/l2.gif" width="200" height="200"><br>
<img src="../../images/htm/l3.gif" width="200" height="200">
<img src="../../images/htm/l4.gif" width="200" height="200">
<img src="../../images/htm/l5.gif" width="200" height="200">
<br>
Figure 1: Subdividing the sphere, all triangles planar for simplicity.<br>
Triangle sides are always great circle segments.
</center>

<p>
This scheme for subdividing the sphere has been advocated earlier
[1]. Some methodologies can be found in [2] The
idea of the HTM has been described in [3], and in more
detail in [4].

<br>
<hr>
<table>
<tr>
<td><center>Prev</center></td>
<td><center><a href="constr.aspx">Next</a></center></td>
<td><center><a href="default.aspx#online">Contents</a></center></td>
</tr>
</table>

<hr><%	Server.Execute("../../SkyFooter.aspx" + "?" + Parameters);%>