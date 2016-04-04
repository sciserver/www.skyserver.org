<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string author ="William O'Mullane";
	string email ="womullan.edu";
	string cvsRevision = "$Revision: 1.5 $";
	Session["gselect"]="1.2";
	string Parameters = "message="+Title+	"&"+"author="+author+ "&leftMenu=../gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");

%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>
<IMG SRC = "../../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
The Hierarchical Triangular Mesh</h1>
<hr>
<br><br>

<table>
<tr>
<td><center><a href="intro.aspx">Prev</a></center></td>
<td><center><a href="geometry.aspx">Next</a></center></td>
<td><center><a href="default.aspx#online">Contents</a></center></td>
</tr>
</table>

<hr>
<br><br>

<a name="def"><a>
<h3>Definition</h3>

The starting point for the scheme to subdivide the sphere are the 8
spherical triangles with equal size -- the octahedron on the sphere
(see <a href="#figure2">figure 2</a> and first image of <a
href="intro.aspx#figure1">figure 1</a>). A ``spherical triangle'' is given
by three points on the unit sphere connected by great circle segments.
The octahedron has six vertices, given by the intersection points of
the <tt>x,y,z</tt> axes with the unit sphere, which we enumerate
<tt><b>v</b><sub><font size=-1>o</font></sub></tt> through
<tt><b>v</b><sub><font size=-1>5</font></sub></tt> :

<pre>
    ( 0,  0,  1 )         v
                           0

    ( 1,  0,  0 )         v
                           1

    ( 0,  1,  0 )         v
                           2
<div align=right>(1)   </div>
    (-1,  0,  0 )         v
                           3

    ( 0, -1,  0 )         v
                           4

    ( 0,  0, -1 )         v
                           5
</pre>

The first 8 nodes of the Spatial Index are defined as
<pre>

    v     v     v   :  S0                 v     v     v    :  N0
     1     5     2                         1     0     4

    v     v     v   :  S1                 v     v     v    :  N1
     2     5     3                         4     0     3
<div align=right>(2)   </div>
    v     v     v   :  S2                 v     v     v    :  N2
     3     5     4                         3     0     2

    v     v     v   :  S3                 v     v     v    :  N3
     4     5     1                         2     0     1
</pre>

The triangles are all given with the vertices traversed counterclockwise.
The construction of the next level makes use of this ordering.

<a name="figure2"></a>
<center>
<table BORDER=0 CELLSPACING=10 >
<tr>
<td VALIGN=TOP>
<img SRC="../../images/htm/north.jpg" width="240" height="264" >
<td VALIGN=TOP>
<img SRC="../../images/htm/space.jpg" width="240" height="32" ><br><img SRC="../../images/htm/south.jpg" width="235" height="272" ></td>
</tr>
</table>
<br><br>
Figure 2: The 8 root nodes of the HTM quad-tree. The x,y,z axes form a
right-handed system, i.e. the z axis points out of the paper on the
left side and down through the paper on the right.
</center>
<br>

<a name="iter"></a>
<h3>Iteration Step</h3>

A given spherical triangle 
<tt>
(<b>v</b><sub><font size=-1>0</font></sub>,<b>v</b><sub><font size=-1>1</font></sub>,<b>v</b><sub><font size=-1>2</font></sub>)
</tt>
with the vertices
ordered counterclockwise is subdivided into four spherical triangles
using the side-midpoints 
<tt>
(<b>w</b><sub><font size=-1>0</font></sub>,<b>w</b><sub><font size=-1>1</font></sub>,<b>w</b><sub><font size=-1>2</font></sub>)
</tt>
of the starting
triangle

<pre>
            v  +  v
             1     2
    w  =  ------------
     0    | v  +  v  |
             1     2


            v  +  v
             0     2
    w  =  ------------
     1    | v  +  v  |
             0     2
<div align=right>(3)   </div>

            v  +  v
             0     1
    w  =  ------------
     2    | v  +  v  |
             0     1

</pre>

The four new triangles are given by

<pre>
    Triangle 0  :  v    w    w
                    0    2    1

    Triangle 1  :  v    w    w
                    1    0    2
<div align=right>(4)   </div>
    Triangle 2  :  v    w    w
                    2    1    0

    Triangle 3  :  w    w    w
                    0    1    2

</pre>

The node name of the new triangles is the name of the original
triangle with the triangle number appended. If the original node name
was <b>S0</b>, the new node names are <b>S00</b>, <b>S01</b>,
<b>S02</b> and <b>S03</b> (see <a href="#figure3">figure 3</a>). This
iteration can be repeated to any desired depth.  The number of leaf
nodes <tt>N</tt> at a given level depth <tt>d</tt> is given by 

<pre>
                 d
     N(d) = 8 * 4
<div align=right>(5)   </div>
</pre>

<a name="figure3"></a>
<center>
<br>
<img SRC="../../images/htm/triangles.jpg" width="443" height="263">
<br><br>
Figure 3:The quad tree is obtained by subdividing spherical triangles<br>
into four smaller ones. The procedure is repetitive, and the naming<br>
scheme is just to add the number of the triangle to the parent's
name.
</center>

<p>
The recursive process defined by equations (3,4)
defines what we call the Hierarchical Triangular Mesh (HTM). The HTM is
very well suited to build a Spatial Index of 3-dimensional data that has
an inherent spherical distribution - like in Astronomy and Earth Sciences.

<a name="stat"></a>
<h3>Properties and Statistics</h3>

In addition to the number of nodes per iteration level calculated in (5)
we can give the triangle size/area for each level. The triangles will
not have the same size or area but the variation is within tolerable limits.
(See <a href="#figure4">figure 4</a>)

<a name="figure4"></a>
<center>
<br>
<img SRC="../../images/htm/areastat.gif" width="598" height="413">
<br><br>
Figure 4: The triangle area distribution shown here is valid for any<br>
level in the quad-tree (except for the first 3-4 levels where there is<br>
much less scatter). The triangle areas are distributed about 70%<br>
around the mean area. The exact mean area is of course always 1/4th of the<br>
previous level; starting from the octahedron (level 0) where the area of<br>
one triangle is Pi/2. The figure shows that about half the triangles are<br>
less than average size and the other half is bigger than average size<br>
(for each level).
</center>

<p>
The shapes of the triangles are also different. For each level there are more and more differently-shaped triangles. The shape difference is kept within certain limits, though - the maximal inner angle of a triangle never exceeds Pi/2 and is never less than Pi/4.
The sidelengths are also within a fixed minimal and maximal value per level (see <a href="#figure5">figure 5</a>).

<a name="figure5"></a>
<center>
<br>
<img SRC="../../images/htm/sidestat.gif" width="704" height="441">
<br><br>
Figure 5: The length of the triangle sides is displayed per level.<br>
The smallest sidelength encountered is always Pi<sup><font
size=-1>n+1</font></sup><br>
 - this is the subdivision of the side that lies on the edge of the<br>
original octahedron. All the other sides are longer. The maximal<br>
sidelength is always at the center of the level-0 octahedron<br>
triangle. It can be shown that the maximum never extends the minimum<br>
by more than a factor of Pi/2
</center>

<br> The folowing table gives an indication of pixel area and number of htm leaves in HTMs of given depths
<table border="1">
<tr>
<th rowspan=2>Level <th colspan=2> Area(arcmin^2) </th><th rowspan=2>Num Leaves </th>
</tr><tr>
<th>Low     <th> High </th>
</tr><tr>
<td>10  </td><td>  14  </td><td>        29 </td> <td> 8,388,608 </td>
</tr><tr>
<td>11  </td><td>  3 </td><td>           7.3 </td> <td> 33,554,432 </td>
</tr><tr>
<td>12 </td><td>   0.86      </td><td>  1.8 </td> <td> 134,217,728 </td>
</tr><tr>
<td>13  </td><td>  0.21  </td><td>      0.45 </td> <td>  536,870,912</td>
</tr><tr>
<td>14 </td><td>   0.05  </td><td>      0.11 </td> <td> 2,147,483,648 </td>
</tr><tr>
<td>15  </td><td>  0.01 </td><td>       0.028 </td> <td> 8,589,934,592 </td>
</tr><tr>
<td>20 </td><td>    1.3E-05</td><td>  2.8E-05 </td> <td>  8,796,093,022,208</td>
</tr><tr>
<td>25  </td><td>   1.0E-08 </td><td> 2.1E-08 </td> <td>  9,007,199,254,740,922</td>
</tr>
<table>

<hr>
<table>
<tr>
<td><center><a href="intro.aspx">Prev</a></center></td>
<td><center><a href="geometry.aspx">Next</a></center></td>
</tr>
</table>


<hr><%	Server.Execute("../../SkyFooter.aspx" + "?" + Parameters);%>