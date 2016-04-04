<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - SkyNode";
	string cvsRevision = "$Revision: 1.2 $";
	Session["gselect"]=2;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=../buildyourown/gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<h2>Resources </h2>
<table border="1">
<tr><td>Slides on how to build a SkyNode from Alberto Conti</td><td><a href="BuildSkyNode.ppt"> How to (ppt) </a></td></tr>
<tr><td>The WebService Files</td><td><a href="skynode.zip"> SkyNode.zip </a></td></tr>
<tr><td>The SQL Server Files</td><td><a href="skynode-sql.zip"> SkyNode-sql.zip </a></td></tr>
</table>

The SkyNode has two parts: The Database and The WebService. Each are dealt with below.

<h2>The Database  </h2>
<p> It is assumed you have SQL Server. If so :
<ol>
	<li> Grab <a href="skynode-sql.zip"> SkyNode-sql.zip </a></li>
	<li> unpack it - it creates a skynode-sql directory. </li> 
	<li>If SQLServer is not running start it now </li>

<li> If you do not have SkyServer or HTM installed then go to the bat directory and run installHtm.bat.
<br> This is harmless in any case so you may just want to do it.
<br> Output from the command is in the logHtm.txt - check this to make sure it ran OK.
</li>

	<li> You need to edit skynode-yourschema.sql in the sql folder 
	<br> NOTE: You need to do this even if you are not creating the schema - the documentation is built from this file.
</li>
	<li> if you do not have an HTM table you should create one and populate it with your
		<pre>         objids,htmid,ra,dec,cx,cy,cz</pre>
	<li> If you have not already created a schema then edit build-Skynode.bat and uncomment
		the call to skynode-yourschema.sql to create it i.e. remove ':' from : 
	<pre>:osql -d%DB% -E -n -i%SQL%skynode-yourschema.sql 	>>log.txt </pre>
</li>

	<li> If you don't already have a database create one in SQLServer </li>
	<li> The scripts create a user called 'skynode' if you wish to use an other user name
and login then edit skynode-initUser.sql in the sql directory. Change skynode at the top of the file :
<pre>
------------------------------------
SET @username = N'skynode';
</pre>
<li> Finally you should create a view PhotoPrimary which is a select from your main table. </li>
You may also modify the password here. </li>
	<li> Go to the bat directory (at a cmd prompt) and run build-Skynode.bat passing the database name.
	<br> Check the file log.txt to See if the script had any problems.
	</li>

</ol>
<p> You should now have a database which you may log into using the skynode user (or the name
you choose). You should be bale to do : 
<pre>         select dbo.fHtmlookupEq(23.5,45.3)
</pre>
   which returns 17375844608553
</p>





<h2> The WebService </h2>
If you have the database and IIS all set up then just grab 
<ol>
<li> Grab <a href="skynode.zip"> SkyNode.zip </a></li>
<li>Unpack it to a directory</li>
<li> Modify web.config to point to your database . i.e. 
edit this line (near end of file) :
<pre>       < add key="SqlConnection.String" 
         value="Initial Catalog=; Data Source=; User ID=; Password=;Connect Timeout=90" />
</pre>
insert the database name, server name, user and password e.g :
<pre>    value="Initial Catalog=skynode; Data Source=localhost; User ID=skynode; \
		Password=*** ;Connect Timeout=90" /> </pre> 

</li>
<li> Modify the info tags to give your information especially :
<pre>
		< add key="Info.SURVEYNAME" value="YOUNAMR" />
		< add key="Info.SURVEYAREA" value="All sky" />
		< add key="Info.LOCATION" value="YOUR LOCATION" />

</pre>
<li> Make a virtual directory in IIS to point to the SkyNode directory with the files in it.  
<br> you may need to create the application for the directory in IIS - 
	although it should be done upon Virtual Directory creation.</li>
<br> Assuming you made a virtual directory SkyNode then you should be able to go to
<br> <a href="http://localhost/skynode/skynodews.asmx" target="SkyNode">http://localhost/skynode/skynodews.asmx</a>
</li>
<li> <a href="mailto:budavari@pha.jhu,edu"> Tell us </a>so we may add it to the server </li>
</ol>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
