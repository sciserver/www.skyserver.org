<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - HTM";
	string author ="William O'Mullane";
	string email ="womullan.edu";
	string cvsRevision = "$Revision: 1.7 $";
	Session["gselect"]=2;
	string Parameters = "message="+Title+	"&"+"author="+author+ "&leftMenu=gutter.aspx"+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ");
%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);

%> 
<h1> <IMG SRC = "../images/htm/htmsphere.jpg" width="109" height="116">&nbsp;&nbsp;
HTM Implementation</h1>
<hr><br>
<dl>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#req">
Background
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "platforms.aspx">
Tested Platforms
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#doc">
Documentation
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#download">
Download
</A>
<BR>
<dd>
<IMG SRC = "../images/balls/purpleBall.gif" width="14" height="14">
<A HREF = "#related">
Related developments - HTM users.
</A>
</dl>

<hr>
<ul>

<a name="req"></a>
<h2>Background</h2>

<p>
The HTM Implementation has evolved a lot over the past few years.
Initially, Alex Szalay put together the first C code that generated
the complete HTM index and was able to perform most of the querying.
Robert Brunner wrote the first C++ version, calling it AstroMap.  When
we first started to receive 'real' data in 1998, we gathered enough
experience to know where the bottlenecks lie. The code was completely
redesigned and rewritten in C++ by Peter Kunszt in 1999, based on the
initial C implementation, improving the performance by factors up to
00. In 2000/2003 George Fekete proprosed a redesign which would have changed the numbering sequence of the ids. This was not considered a good option but a few modifications were made to simplify the code. Another factor 4 speedup was achieved by this. In the current version partial and full lists have been droped and a set of ranges of ids are returned from an intersection.
The current version is 2.1. 
<p>
The code should work on every computer with a C/C++ compiler or with
JDK1.2 installed for the java version.  It has been successfully
tested on <a href="platforms.aspx">these platforms</a>.

<p>
There are 3 APIs currently forseen:

<p>
<dl>
<dd>
<IMG SRC = "../images/balls/redBall.gif" width="14" height="14"> C++ set of classes and a cc_aux c file with c functions <BR>
<dd>
<IMG SRC = "../images/balls/redBall.gif" width="14" height="14"> a Java2 package<BR>
<dd>
<IMG SRC = "../images/balls/redBall.gif" width="14" height="14"> a C# package (tbd) <BR>
</dl>

<a name="doc"></a>
<h2>Documentation</h2>
<p>
Some online documentations is available:
<dl>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="doc/progguide.aspx">
Programmers Quick Guide </a><br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="doc/c++/aindex.html">
C++ classes and methods</a><br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="doc/java/index.html">
Java class documentation (JavaDoc)</a><br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="doc/default.aspx#online">
Detailed description</a><br>
</dl>
<a name="download"></a>
<h2>Download</h2> 
<p>
The HTM code that can be downloaded here has the following functionality:
<br><br>
<ul>
<li>
For a given point <i>(x,y,z)</i> on the sphere, return the node name it belongs to up to a given level
<li>
For a given node name, return the 3 vertex vectors
<li>
Bit-encode and decode node name into an integer
<li>
Supports complicated query surfaces on the sphere, returning
the node ids for each node fully or partially contained in the query surface
</ul>

<p>
The documentation is included with each package. If you are interested
in very detailed descriptions of the HTM, please read one of the <a
href="doc/default.aspx#paper">publications</a> or see the online <a
href="doc/default.aspx">details</a>.
<p>
<b>NOTE:</b> To download - depending on your browser settings - you
might have to hold the shift key while clicking on the link you're
interested in.

<h3>C++ classes</h3>
<dl>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/cpp/htmIndex.tar.gz">
C++ classes (2.1)</a>, in .tar.gz with makefile  also contins visuall c++ project (136K)<br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/cpp/htmDoc.tar.gz">
C++ class documentation only (HTML)</a>, in .tar.gz (20K)<br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/cpp/htmdoc.zip">
C++ class documentation only (HTML)</a>, in .zip (27K)<br>
</dl>

<h3>Java package - Version 3.0.1</h3>
<dl>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/java/htmIndex.jar">
Java htm package htmIndex.jar</a> with examples (68K)<br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/java/htmdocs.jar">
Java HTML documentation</a> javadocs in a jar file (276K)<br>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/java/htmSrc.jar">
Java HTM source </a>includes build.xml for bulding with ant and jbx Jbuilder project. (276K)<br>
</dl>
<h3>SQL Server Package Version 2.</h3>
<dl>
<dd>
<IMG SRC = "../images/balls/blueBall.gif" width="14" height="14">
<a href="src/sql/HtmV2.zip"> SQL Server DLL and Strored Procedures </a> allows calling of HTM functions inside SQL Server. Includes htmdll_2_0.doc which explains how to use this.
</dl>

</ul>
<a name="related"></a>
<h2> Related Developments</h2> 
<p>

At STScI HTM is used for partitioning the multi terabyte <A href="http://chart.stsci.edu/gsc/GSChome.htm">GSC2 catalogue </a>. <A href="http://chart.stsci.edu/showsky/about.htm">ShowSky </A> a java tool for plotting images and objects contains HTM plotting features. 
<p>
The <a href="http://gaia.am.ub.es/"> ESA cornerstone mission GAIA </a>is currently studying HTM to partition similations and data. Prototypes have been built on HTM using Java.
<p>
The <a href="http://amwdb.u-strasbg.fr/saada"> SAADA </a> use HTM for access to astronomical datbases.

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);%>