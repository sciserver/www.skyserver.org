<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string author ="William O'Mullane";
	string email ="womullan.edu";
	string cvsRevision = "$Revision: 1.2 $";
	Session["gselect"]="1.3";
	string Parameters = "message="+Title+	"&"+"author="+author+ "&leftMenu=../gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>Geometrical Querying</h1>

We want to have a generic possibility to intersect the HTM with any
given surface on the sphere. For a certain area, we want to get all
HTM nodes of a given depth that are either completely or partially
covered by it.  We would like to know for each triangle which category
it falls into -- completely contained in the area, partially contained
or not at all.  In this section, we give the geometry primitives that
can be used to define any area on the sphere.  These primitives can
easily be intersected with the HTM nodes to decide into which category
they fall. We give the outline of the algorithms that can be used to
deduce the HTM category for any area composed of the geometry
primitives.

<h2>Geometry Definition</h2>

<h3>Constraints</h3>

The <i>constraint</i> is our basic geometry primitive. It is
a cap on the unit sphere. We get a constraint by slicing it
off the sphere with a plane. Any constraint can be characterized 
by the direction of the plane \vv and its distance d from the origin:
<pre>
                 ->           -> 
          c := { v ; d }     |v| = 1    ;    -1 < d < 1
<div align=right>(6)   </div>
</pre>

We allow for 'negative' constraints d<0, which cover more than half of the
spherical surface. They look like 'holes' on the sphere.  The sign of the
constraint is defined to be the sign of d: 
<pre>
          sign(c) := negative     d < 0
                     zero         d = 0
                     positive     d > 0
<div align=right>(7)   </div>
</pre>
We also define the opening angle of a constraint:
<pre>
          phi<sub>c</sub> = arccos(d)
<div align=right>(8)   </div>
</pre>

Examples: {v = (0,0,1) ; d = 0.5 } defines the cap north of 30<sup>o</sup>
latitude north. {v = (0,0,-1); d = -0.5 } defines everything but the
same cap.

<h3>Convexes</h3>
<p>
We define a convex as the logical AND of constraints, i.e. the
intersection of caps on the sphere:
<pre>
          x := c<sub>1</sub>  &&  c<sub>2</sub>  &&  <FONT FACE="Symbol">&#183;&#183;&#183;</FONT>   &&  c<sub>n</sub>                 n in N<sup>+</sup>
<div align=right>(9)   </div>
</pre>

Such a geometry is a convex in 3D but not necessarily a convex area on
the spherical surface. 
As an example, the convex { (0,0,1) ; -0.01} && { (0,0,-1)
; -0.01} defines a narrow strip around the equator.  It is not even
true that convexes are always a contiguous area on the sphere. Imagine
the convex given by the intersection of two great-circle strips that are
not in the same plane -- the resulting convex is given by two disjoint
areas where the strips meet. 
Consider as another example a cube centered
around the origin whose corner points are barely outside the unit
sphere. Then the corresponding convex on the sphere is given by the 8
segments just around the cube corners. Note that all these convexes 
are composed of negative constraints.
<p>
However, convexes that are composed entirely of positive and zero constraints always define a convex area on the sphere, which are easier to handle.  Thus, it makes sense to define a sign for the convexes too:
<pre>
    <b>sign</b>(x) := negative     c<sub>i</sub>  all negative or zero
               zero         c<sub>i</sub>  all zero
               positive     c<sub>i</sub>  all positive or zero
               mixed}       at least one positive and one negative constraint
<div align=right>(10)   </div>
<a name="convexsign"> </a>
</pre>
The sign will be important when we actually calculate the
intersections with the HTM.

<h3>Domains</h3>

We define a domain to be logical OR of convexes:
<pre>
d := x<sub>1</sub>  ||  x<sub>2</sub>  ||   <FONT FACE="Symbol">&#183;&#183;&#183;</FONT>       ||  x<sub>n</sub>            n in <i> N</i><sup>+</sup> 
<div align=right>(11)   </div>
</pre>
Thus a single domain can represent any complicated area on the sphere.
If we devise a generic method to intersect domains with the HTM triangles,
we have a powerful indexing tool at hand.


<h1>Simplifications</h1>
Convexes and domains may contain redundant constraints that can be
localized and eradicated. The most trivial cases are the following:
Consider a convex made out of two constraints <i>c<sub>1</sub></i> and <i>c<sub>2</sub> </i> with
opening angles <i>varphi<sub>c1</sub></i> and <i>varphi<sub> c2</sub></i>
respectively. Define the angle between them as 
 <pre>
          ->   ->
          v<sub>c1</sub><FONT FACE="Symbol">&#183;</FONT> v<sub>c2</sub> = cos(theta<sub> c1 c2</sub>) 
<div align=right>(12)   </div>
</pre>

<ul>
<li> If both constraints are non negative, we can drop <i>c<sub>2</sub> </i> if 
<pre>
      varphi<sub>c1</sub> >= varphi<sub> c2</sub> + theta<sub> c1c2</sub> 
</pre>

<li> If both constraints are negative or zero, we can drop <i>c<sub>2</sub> </i> if
<pre>
      varphi<sub> c2</sub> >= varphi<sub> c1</sub> + theta<sub>c1c2 </sub>
</pre>
<li> And we can drop the whole convex if
<pre>
      varphi<sub>c1</sub> + varphi<sub>c2</sub> <= theta<sub>c1c2</sub>}
</pre>
</ul>

These simplifications are true even if there are more than two
constraints in the convex, we can check each pair of convexes for the
above cases.

For zero convexes, where all constraints are great circles, we can
easily do more simplifications.  The above cases only would apply if
we have two exactly opposing half spheres, i.e. <i>v<sub>1</sub>  = -v<sub>2</sub> </i>.
Zero-convexes can be drawn as a polygon on the
sphere. The corners of the polygon can be localized using the
following algorithm (Nomenclature : <i> L</i> is a list containing all
constraints that have been already processed, <i> P</i> is a list of
the polygon corners that are determined one by one):
<dl>
<dd>1. Assume there are <i>n</i> constraints in the convex.
Start with constraint <i>c<sub>i</sub>, i=0</i>.
<dd>2. Get the intersection points with convex <i>c<sub>j</sub> </i>,
<i>j not in L </i>and <i>j not= i</i>, which for zero constraints
are given by the cross product of the two constraint vectors
<pre>
          ->       ->  ->
          <i>W</i><sub>1,2</sub> = <FONT FACE="Symbol">&#177;</FONT>|v<sub>i</sub> X v<sub>j</sub>|
</pre>
<dd>3. Check whether any of the two intersection points lies inside all
the other constraints, i.e. if 
<pre>
          ->   -> 
          <i>W</i><sub>1,2</sub><FONT FACE="Symbol">&#183;</FONT> v<sub>k</sub>  > 0              k not= i,j
</pre>
<dd>4. If one of the points <i>w<sub>1,2</sub></i> does lie within all
constraints, append it to the list of polygon corners <i>P</i>, insert
<i>i</i> into the list of visited constraints <i>L</i> and continue at
point 2 with <i>i=j</i>.
<dd>5. If a constraint <i>i</i> does not fulfill point 4, i.e. there are no
intersection points to be found that lie within all other convexes, it
means that the polygon of the convex lies completely inside or
completely outside of <i>c<sub>i</sub> </i>. Test for one of the already known points
in <i>P</i> whether it is inside <i>c<sub>i</sub></i>  (if <i>P</i> is empty, just
continue and come back to this constraint later). If it is inside,
drop <i>c<sub>i</sub></i>, if it is outside, drop the entire convex.
<dd>6. If there are no <i>j not in  L</i> to be found, we are
done, <i> P</i> contains an ordered list of all polygon corners.
</dl>

<hr><%	Server.Execute("../../SkyFooter.aspx" + "?" + Parameters);%>