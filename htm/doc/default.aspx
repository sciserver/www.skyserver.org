<%@ Page language="c#" %>
<!-- #include file="../../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string cvsRevision = "$Revision: 1.7 $";
	Session["gselect"]=1;
	string Parameters = "message="+Title+	"&"+"author="+author+ "&leftMenu=../gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1>
<IMG SRC = "../../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
HTM Documentation</h1> 
<hr>
<br>

<dl>
<dd>
<IMG SRC = "../../images/balls/purpleBall.gif" width="14" height="14">
<a HREF = "../#desc">
Brief description
</a>
<BR>
<dd>
<IMG SRC = "../../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#online">
Online Documentation
</A>
<BR>
<dd>
<IMG SRC = "../../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "../implementation.aspx#doc">
Online Documentation of the implementation
</A>
<BR>
<dd>
<IMG SRC = "../../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#paper">
Papers
</A>
<BR>
</dl>
<p>
You may get the latest available code from the <a href="../implementation.aspx#do
wnload">download page</a>.
<br>

<hr><p>
<a name="online"></a>
<h2>Online Information about HTM </h2>

<h3><a href="intro.aspx">Brief Introduction to HTM</a></h3>
<h3><a href="constr.aspx">The Hierarchical Triangular Mesh Construction</a></h3>
<ul>
<a href="constr.aspx#def">Definition</a><br>
<a href="constr.aspx#iter">Iteration Step</a><br>
<a href="constr.aspx#stat">Properties and Statistics</a><br>
</ul>
<h3><a href="geometry.aspx">Geometrical Querying with HTM</a></h3>
<h3><a href="userguide.aspx">Users guide to the software</a></h3>
<h3><a href="progguide.aspx">Programmers quick guide to the software</a></h3>
<h3><a href="HTMinterface1.7.doc">Word Document Describing motivation for HTM3.0</a></h3>
<h3>
<a href="http://towelie.pha.jhu.edu:8090/wil/jsp/htmtools.jsp"> Lookup HTMID or do simple intersect  online </a>
</h3>
<hr>
<a name="paper"></a>
<h2>Papers</h2>

<p>
Further documentations and the basic ideas can be found in the
following papers published on this subject:

<dl>
<dt>
<h3>ADASS Conference in Kona/Hawaii 1999</a></h3>
<dd>
<table>
<tr> <td class="pubtitle">
<a href="adass99.ps">The Indexing of the SDSS Science Archive</a>
</td> </tr>
<tr><td class="auth">
P. Z. Kunszt, A. S. Szalay, I. Csabai, A. R. Thakar
</td> </tr>
<tr><td class="addr">
Dept. of Physics and Astronomy, Johns Hopkins University, Baltimore, MD 21218
</td></tr>
<tr><td class="ref">
in Proc ADASS IX, eds. N. Manset, C. Veillet, D. Crabtree, (ASP Conference
series), 216, 141 (2000).
</td></tr>
</table>
<dt>
<h3>MPA/ESO/MPE Joint Astronomy Conference/Garching 2000</h3>
<dd>
<table>
<tr> <td class="pubtitle">
<a href="kunszt.ps.gz">The Hierarchical Triangular Mesh</a>
</td> </tr>
<tr><td class="auth">
P. Z. Kunszt, A. S. Szalay, A. R. Thakar
</td></tr>
<tr><td class="addr">
Dept. of Physics and Astronomy, Johns Hopkins University, Baltimore, MD 21218
</td></tr>
<tr><td class="ref">
in Mining the Sky: Proc. of the MPA/ESO/MPE workshop, Garching, A.J.Banday,
S. Zaroubi, M. Bartelmann (ed.); (Springer-Verlag Berlin Heidelberg), 631-637
(2001).
</td></tr>
</table>
<br>
<table>
<tr> <td class="pubtitle">
<a href="womullan_082000.pdf">Splitting the sky - HTM and HEALPix.</a>
</td> </tr>
<tr><td class="auth">
W.O'Mullane
</td></tr>
<tr><td class="addr">
Astrophysics Division, Space Science Department of ESA, ESTEC, 2200 AG Noordwijk, The Netherlands.
</td></tr>
<tr><td class="auth">
A. J. Banday 
</td></tr>
<tr><td class="addr">
MPI für Astrophysik, P.O. Box 1523, D-85740 Garching, Germany. 
</td></tr>
<tr><td class="auth">
K. Gorski
<tr><td class="addr">
European Southern Observatory (ESO), Karl Schwarzschild Strasse 2, 85748 Garching, Germany
</td></tr>
<tr><td class="auth">
P. Z. Kunszt, A. S. Szalay, 
<tr><td class="addr">
Dept. of Physics and Astronomy, Johns Hopkins University, Baltimore, MD 21218
</td></tr>
</table>
</dl>
</ul>

<hr><%	Server.Execute("../../SkyFooter.aspx" + "?" + Parameters);%>