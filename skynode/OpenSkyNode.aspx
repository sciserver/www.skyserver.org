
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "How To Set Up An Open SkyNode.";
	string cvsRevision = "$Revision: 1.3 $";
	Session["gselect"]=1;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=../buildyourown/gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<p>This document covers how to install a full SkyNode on a Windows machine
running Microsoft's database and web-server applications, SQL Server and IIS
respectively.  This document was born out of my own frustration at the lack
of good documentation for setting up SkyNodes.  I hope that you find it
helpful.</p>

<p>This document assumes that you are at least reasonably familiar with SQL
Server, especially Enterprise Manager and Query Analyzer.</p>
p>If you find any bugs, errors, typos, or anything else wrong, please send
me an e-mail.</p>

<h2> Required Downloads </h2>
<p> You will require this <a href="openskynodesql.zip"> ZIP file which contains the SQL and creat-db.bat</a>.
<br> Unzip this you will need it bellow.

<p> You also need the <a href="http://openskyquery.org/Sky/SkySite/template.zip">
latest OpenSkyNode Template.zip  this is refered to below as template.zip</a> just put
it somewhere safe for now.

<p>
<h2>Installation Overview:</h2>

<p>Included with this document should be a batch file named
<code>create_db.bat</code>, a folder named <code>sql</code> containing a number
of SQL scripts, a folder named <code>dll</code> containing a single DLL, and a
folder named <code>test</code> containing some test SQL scripts.  In its
simplest form, the installation should involve 4 steps:</p>

<ol>
  <li>Creating a new database and a primary table to hold the data you want
      to make available via a SkyNode</li>
  <li>Importing your data into this database and table</li>
  <li>Running the script <code>create_db.bat</code> in order to set up all of
      the necessary database configuration</li>
  <li>Unzipping the supplied web-service libraries and applications to a
      directory and making this directory available to the web-server IIS</li>
</ol>

<p>Almost all of the work in setting up a SkyNode is accomplished by the batch
file in step 3.   The other steps will be discussed in the next few
sections.</p>

<h2>1: Creating a Database and Table</h2>

<p>Open the script <code>createDB.sql</code> in the <code>sql</code> directory
in Query Analyzer.  This script is set by default to create a database named
<code>SkynodeData</code>.  Edit the two lines at the top of the file that look
like this:</p>

<code>
---------------------------<br>
create database SkynodeData<br>
go                         <br>
use SkynodeData            <br>
---------------------------<br>
</code>

<p>You can name the database anything that you want, so be sure to give it a
descriptive name.  You must change <em>both</em> occurrences of
<code>SkyNodeData</code>, though.</p>

<p>Now you need to customize the schema for the primary table in this new
database.  By default the name of the primary table is <code>PhotoObjAll</code>.
The install scripts assume this, so you must change all occurrences of
<code>PhotoObjAll</code> in the install scripts if you wish to use another name.
Scroll down to the bottom of the script and add in any additional rows that you
need for your database where the comments indicate.  For example, if you have
redshift data you could add a line like this:</p>

<code>
redshift real not null<br>
</code>

<p>Note that you need to put commas after every line except the last one.  The
data types you will most likely need are <code>int</code> (32 bit),
<code>bigint</code> (64 bit), <code>real</code> (32 bit, single precision), and
<code>float</code> (64 bit, double precision).</p>

<p>Every SkyNode must contain rows for right ascension, declination, and a
unique object id (ra, dec, and objid respectively) as well as variables
related to the hierarchical triangular mesh (HTM) functions that are used in
querying the database (<code>cx, cy, cz,</code> and <code>htmid</code>).  The
HTM related variables will be filled in by the install script; you don't need
to supply any data for them.</p>

<p>Before running the script, use the check syntax button (the blue check mark)
to make sure you haven't made any typos.  The only problem is that Query
Analyzer will always complain that the database you want to create doesn't
exists.  In order to check the syntax of the rest of the script, you need to
temporarily comment out the database creation lines, then check the syntax,
then uncomment the database creation lines.  Then run the script (the green play
button).  For most SQL scripts, it's very important that you run the script on
the right database.  In this case, it doesn't matter because the script
will automatically use whatever database it creates.</p>

<p>If you make a mistake, you can rerun the script if you comment out the lines
that create the database at the top (<code>"--"</code> without the quotes will
comment out a line).  The script checks whether the table PhotoObjAll exists in
the database and drops (deletes) it if it does.  Note, however, that if you
rerun the script you will have to run it under the right database name
(SkynodeData by default).  Make sure that the proper database name is selected
in the drop down box in Query Analyzer.  If you mess up and accidentally add
<code>PhotoObjAll</code> to another database (most likely <code>master</code>),
you can delete it with the command <code>drop table PhotoObjAll</code>, which
of course, you must run from the proper database.  Enterprise Manager can also
delete tables if you prefer.</p>

<p>Once you have customized and run this script, you should have a new database
and table.  Open Enterprise Manager, navigate to the database you created, and
check under Tables that there is a table named <code>PhotoObjAll</code>.</p>

<p>Finally, it would probably be a good idea to save this modified SQL script
under a different name so that you have it for future reference.  If something
goes wrong, you won't have to reedit anything.</p>

<h2>2: Importing Your Data</h2>

<p>If you're like most astrophysicists, the data you want to import is
contained in a plain text file with a column for each item (or at least in a
format that can be easily converted to this format).  Luckily for you, SQL
Server has a simple wizard that can import your data from such a file.  There
are a couple of things that will probably make things a little simpler for you
when importing your data.</p>

<p>First, it's probably a good idea if you write out only the data that you
want to import into the SkyNode.  You can tell the import wizard to ignore
certain columns, but it's definitely much easier just to leave out any data
that you don't need.  Simple Unix tools like <code>awk</code> can extract out
what columns you need simply and quickly.  Second, it will make things much
easier if you output the columns in the order they appeared in the schema you
created above.  For example, in the default schema, the rows are created in the
order <code>ra, dec, objid</code>.  You can make importing the data much easier
by ordering the columns in your text file as <code>ra, dec, objid</code>.
Third, the import wizard claims to be able to understand header lines and fixed
width columns, but in my experience these two things cause a lot of problems.
Stick to using columns separated by a delimiter such as a single space or
comma without any data headers.  If you follow these three guidelines,
importing your data should be extremely easy.</p>

<p>Note that I wrote this guide using Windows Server 2000 and SQL Server
2000, so the descriptions here might vary slightly from other versions.</p>

<p>OK, so now it's time to actually import your data.  Open Enterprise Manager,
navigate to your database, then right click on it and select
<code>Import Data...</code> from the <code>All Tasks</code> menu.</p>

<img src="./web/fig1.gif" alt="Right click menu" width="509" height="550">

<p>This will bring up the import wizard.  Click <code>Next</code> on the intial
window, then a second window named <code>Choose a Data Source</code> should
appear.  Click the <code>Data Source</code> drop down selector, then select
<code>Text File</code> at the very bottom.  A <code>File Name</code> dialog box
appears.  Click the button next to it and select the file of data you want
to import.  Note that Windows only displays files ending in <code>.txt</code>
and <code>.csv</code> by default.  Click <code>Next</code> to go to the next
screen.</p>

<img src="./web/fig2.gif" alt="Text File selection box" width="503" height="387">

<p>The next window should be <code>Select file format</code>.  If you followed
the instructions at the beginning of this section, then you should select a
<code>Delimited</code> file.  If you created your file on Unix rather than
Windows, then you will need to change the <code>Row delimiter</code> to
<code>{LR}</code> instead of <code>{CR}{LF}</code>.  You can also just open
your file in Wordpad and resave it, which will convert it to the standard
Windows line endings.</p>

<p>The next window is titled <code>Specify Column Delimiter</code>.  Select the
delimiter you used when creating your data.  If you used a space, you need to
enter a space in the box marked <code>Other</code>.  Your data should appear
in the preview window below once you have entered the delimiter.</p>

<p>The next window is <code>Choose a destination</code>.  Here you want to make
sure that your database is selected from the drop down box marked
<code>Database</code>.  It should be by default.</p>

<p>The next window is <code>Select Source Tables and Views</code>.  This screen
is very important because here you must specify where to put the data to import
in your database.  Click on the text in the <code>Destination</code> column.
This should bring up (previously hidden) drop down box of tables.  Select 
<code>PhotoObjAll</code> from the list.  It will look something like
<code>[SkyNodeData].[dbo].[PhotoObjAll]</code>.  Now click the button with
three dots in the <code>Transform</code> column.  This will bring up a window
titled <code>Column Mappings and Transformations</code>.  Here you must map
the source columns of the input file to the rows created in your primary table.
Because you won't have data for <code>cx, cy, cz</code> and <code>htmid</code>,
you will need to set them to ignore.  If you followed the advice at the
beginning of this section, then the mapping should be correct by default.
Once you have everything set properly, click <code>OK</code>.  Before clicking
<code>Next</code>, you can click <code>Preview</code> to do a final check that
everything is set properly before you finally import everything.</p>

<img src="./web/fig3.gif" alt="Table source" width="502" height="388">
<br><br>
<img src="./web/fig4.gif" alt="Transform box" width="495" height="452">

<p>As a side-note, it is very important that when you created your schema that
the HTM variables be set to <code>Nullable</code>.  Otherwise the importer will
complain when you actually run it.  Unless you changed the default schema, this
shouldn't be a problem.</p>

<p>Finally, click <code>Next</code> twice and the importer should run.  If
something goes wrong, the importer should give you an error message.  If the
data is imported successfully, you can test whether the data was imported
properly by running a test SQL command.  Open up Query Analyzer and run the
following command on your database (make sure not to run it on
<code>master</code>):</p>

<code>
select top 10 * from PhotoObjAll<br>
</code>

<p>This should print out the first 10 entries from the file that you imported.
Make sure that the data is associated with the proper rows.  If not, you can
delete the database from Enterprise Manager, rerun the script
<code>skynode-createDB.sql</code> and import your data again.</p>

<h2>3: Running the Script</h2>

<p>Before you run the install script, you need to modify one of the SQL scripts
if you modified the default schema in step 1 (i.e. if you're using more than
just <code>ra, dec,</code> and <code>objid</code> in your database).  Open
<code>skynode-fillMetadataTables.sql</code> in the <code>sql</code> directory
in an editor and scroll down to the section that looks like this:</p>

<code>
---------------------------------------------------------------------------<br>
--                                                                         <br>
-- Add in descriptions of all of the columns that you added to the main    <br>
-- table PhotoObjAll here                                                  <br>
--                                                                         <br>
---------------------------------------------------------------------------<br>
</code>

<p>You need to add descriptions of any of the additional data that you want to
store in the database here.  For example, if you included photometric redshift
data with a column named <code>photo_z</code>, then you would add a line that
looks like this:</p>

<code>
insert DBColumns (tablename, name, unit, ucd, enum, description)        <br>
values ('PhotoObjAll', 'photo_z', '', '', '', 'Photometric redshift')   <br>
</code>

<p>Note that in SQL, strings are enclosed in single quotes, not double quotes.
The 3 blank entries (<code>unit, ucd, enum</code>) are optional.  You will need
to add one insert command for every additional row that you added to the schema
in step 1.  This is absolutely crucial for the web-service to be able to read
the data in the database because the web-service code reads the table
<code>DBColumns</code> to determine what data is contained in the database.
Leaving out a row that you added to the schema will make this row invisible to
the web-service.  Once you have finished modifying the script, check its syntax
in Query Analyzer to make sure that there are no typos, but don't run the
script (it's run automatically by the install script).</p>

<p>Once the metadata tables SQL script is modified, the rest of the process
should (theoretically) be trivial.  Open a command prompt, go to the directory
containing the file <code>create_db.bat</code>, and run it.  The batch file
takes two arguments.  The first is the name of the machine the database is
stored on and the second is the name of the database (SkynodeData by default).
To run the script on a database on the local machine (probably the most common
situation), input <code>(local)</code> for the machine name.
Example usage:</p>

<code>
create_db.bat (local) SkynodeData
</code>

<p>As the script runs, it should print out a short message about what it's
doing at every step.  It also outputs a log to <code>create_db.log</code> that
you can review for errors.</p>

<p>Hopefully you won't encounter any problems running the batch file, but if
you do, then it's helpful to know exactly what the batch file is doing.  The
batch file simply runs a series of SQL scripts contained in the <code>sql</code>
directory.  Below is a description of the SQL scripts in the order that they
are run by the batch file and what they actually do.  Because these are SQL
scripts, you can always open them up in a text editor or Query Analyzer and
take a look at what they're actually doing.  Even better, most of the scripts
are designed so that they can be rerun multiple times without causing problems,
so if something fails you can try running a given script in Query Analyzer and
look at the error messages.</p>

<h3>skynode-HTMmaster.sql</h3>
<p>Installs the main HTM procedures and library and grants public access to
them.  Copies the file <code>htm_v2.dll</code> to
<code>C:\Program Files\Microsoft SQL Server\MSSQL\Binn\</code>, which is the
default install location of SQL Server.  If you have installed SQL Server in
another directory, then you will need to copy over the DLL manually to the
<code>Binn</code> directory in the install directory of SQL Server.  The
following extended procedures will be added to that master database (not the
SkyNode database):</p>

<ul>
  <li>xp_HTM2_Lookup</li>
  <li>xp_HTM2_Cover</li>
  <li>xp_HTM2_Cover</li>
  <li>xp_HTM2_toNormalForm</li>
  <li>xp_HTM2_toPoint</li>
  <li>xp_HTM2_toVertices</li>
  <li>xp_HTM2_Version</li>
</ul>

<h3>skynode-htmInstall.sql</h3>
<p>Installs more HTM related functions into the SkyNode database.  The
following functions and stored procedures will be created:</p>

<ul>
  <li>fHtmLookup</li>
  <li>fHtmLookupError</li>
  <li>fHtmCover</li>
  <li>fHtmCoverError</li>
  <li>fHtmToString</li>
  <li>fHtmToNormalForm</li>
  <li>fHtmToNormalFormError</li>
  <li>fHtmToVertices</li>
  <li>fHtmToPoint</li>
  <li>fHtmVersion</li>
  <li>fHtmLookupXyz</li>
  <li>fHtmLookupEq</li>
</ul>

<h3>skynode-nearFunctions.sql</h3>
<p>Creates the following functions / stored procedures in the SkyNode
database:</p>

<ul>
  <li>fGetNearbyObjEq</li>
  <li>spNearestObjEq</li>
  <li>fGetNearestObjEq</li>
  <li>fGetNearestObjIdEq</li>
  <li>fGetNearbyObjXYZ</li>
  <li>fGetNearestObjXYZ</li>
  <li>fGetObjFromRect</li>
  <li>fDistanceArcMinEq</li>
  <li>fDistanceArcMinXYZ</li>
</ul>

<h3>skynode-calcHTM.sql</h3>
<p>Calculates the HTM related variables in the primary table
<code>PhotoObjAll</code> (<code>cx, cy, cz, htmid</code>) using the HTM
functions which were installed above.</p>

<h3>skynode-webSupport.sql</h3>
<p>Installs functions / stored procedures related to interacting with the web
service in the SkyNode database.  The following will be installed:</p>

<ul>
  <li>replacei</li>
  <li>spExecuteSQL</li>
  <li>fIsNumbers</li>
  <li>spSkyServerColumns</li>
  <li>spSkyServerConstraints</li>
  <li>spSkyServerDatabases</li>
  <li>spSkyServerFormattedQuery</li>
  <li>spSkyServerFreeFormQuery</li>
  <li>spSkyServerFunctionParams</li>
  <li>spSkyServerFunctions</li>
  <li>spSkyServerIndices</li>
  <li>spSkyServerTables</li>
  <li>fDocColumns</li>
  <li>fDocFunctionParams</li>
  <li>fEnum</li>
  <li>spDocEnum</li>
  <li>spDocKeySearch</li>
</ul>

<h3>skynode-getMatch.sql</h3>
<p>Installs the procedure for performing cross matches.  Again, the procedure
<code></code><code></code>in installed in the SkyNode database.</p>

<ul>
  <li>spGetMatch</li>
</ul>

<h3>skynode-createViews.sql</h3>
<p>Creates all of the necessary views.  In order for the SkyNode to function,
there are several views of the primary table and HTM variables that must be
created, which are:</p>

<ul>
  <li>PhotoPrimary</li>
  <li>PhotoObj</li>
  <li>Htm</li>
</ul>

<h3>skynode-fillMetadataTables.sql</h3>
<p>Creates and populates the metadata tables <code>DBObjects, DBColumns,</code>
and <code>DBViewCols</code>.  These tables contain strings describing all of
the tables, views, functions, and procedures contained in the database.
Inaddition to being used by the web-service when querying the database, these
tables are used by the script <code>skynode-initUser.sql</code> below in order
to set the permissions for the public user.</p>

<h3>skynode-initUser.sql</h3>
<p>Creates a public user through which the web-service will access SQL Server.
By default this user is named <code>webaccess</code> with the same password,
although you can modify it in the script to anything you like.  Also, the
web-service uses SQL authentication to login, so this needs to be enabled for
the login to function.  See the <strong>Odds and Ends</strong> section
below.</p>

<h2>4: Installing the web-service</h2>

<p>Unzip the file <code>template.zip</code> to the directory where
you want to store the actual webservice.  With IIS you can either use virtual
directories or the central IIS directory, which is
<code>C:\Inetpub\wwwroot\</code>.  This guide does not cover how to set up a
virtual directory.  Unzipping the file should create a directory called
<code>SkyNode</code> containing several files and a <code>bin</code>
subdirectory.  The actual webservice is called <code>nodeb.asmx</code>.  The
other webpage in the directory (<code>default.asmx</code>) is a simple test
page that you will use to check that everything is set up properly.</p>

<p>Once you have unpacked the zip file, you need to tell IIS that this
directory contains a webservice (or <em>application</em> as IIS refers to
it).  Right click on <code>My Computer</code> and choose <code>Manage</code>
from the list.  This will bring up a window titled
<code>Computer Management</code>.  Choose
<code>Services and Applications</code>, then
<code>Internet Information Services</code>, and finally
<code>Default Web Site</code>.</p>

<img src="./web/fig5.gif" alt="Computer Management" width="672" height="526">

<p>Here you will see a list of all the files and folders contained in
<code>C:\Inetpub\wwwroot\</code>.  If you used a virtual directory, you will
have to modify it instead of the <code>Default Web Site</code>.  You should
see a folder entitled <code>SkyNode</code> (or whatever name you may have
renamed your web-service to).  Right click on the name of your web-service
directory and choose <code>Properties</code> from the menu.  About halfway
down the page, there is a  section titled <code>Application Settings</code>.
Click the <code>Create</code> button next to the greyed out
<code>Application Name</code> box.  Leave all of the other settings the
same.  Click <code>OK</code> and you're done with this this part.</p>

<img src="./web/fig6.gif" alt="SkyNode Properties" width="459" height="431">

<p>Next we need to edit the configuration file for the web-service so that it
knows which database in SQL Server to read.  Go to your SkyNode directory
and open the file <code>web.config</code> using any editor.  Look for the 
section at the bottom entitled <code>&lt;appSettings&gt;</code>.  It should
look something like:</p>

<pre>
&lt;appSettings&gt;
  &lt;add key="IVOA_ID" value="ivo:anshar.phyast.pitt.edu/skynode/"/&gt;
  &lt;add key="def_portal_url" value="http://openskyquery.net/Sky/SkyPortal/PortalJobs.asmx"/&gt;
  &lt;add key="LOG_LOCATION" value="C:\Logs\OpenSkyQuery\"/&gt;
  &lt;add key="cstring" 
       value="Initial Catalog=MosaicGrothStrip; Data Source=localhost; User ID=webaccess; Password=webaccess;"/&gt;
  &lt;add key="node_id" value="grothstrip"/&gt;
  &lt;add key="primary_table" value="photoprimary"/&gt;
  &lt;add key="primary_table_key" value="objid"/&gt;
  &lt;add key="sigma" value="1.0"/&gt;
&lt;/appSettings&gt;
</pre>

<p>You need to modify the following keys in this section: <code>IVOA_ID,
LOG_LOCATION, cstring, node_id,</code> and <code>sigma</code>.  If for some
reason you changed any of the other names, you will have to modify other keys
as well.  Below is a description of each key:</p>

<dl>
  <dt>IVOA_ID</dt>
  <dd>A unique identification string, usually taken to be
      ivo:<em>service-url</em>.  Be sure to choose a good descriptor that will
      be unique.
  </dd>
  <dt>LOG_LOCATION</dt>
  <dd>The local folder where logs for the webservice will be created.  Note
      that this folder must have permissions set so that <code>webaccess</code>
      can write to it.
  </dd>
  <dt>cstring</dt>
  <dd>The value of this key contains several important things.
      <code>Initial Catalog</code> should be set to the name of the database
      that you created (<code>SkynodeData</code> by default).
      <code>Data Source</code> should be set to the name of the machine that
      the database is stored on, which is <code>localhost</code> if it is on
      the same machine as the webserver.  Finally, <code>User ID</code> and
      <code>Password</code> should be set to the user name and password for
      SQL Server.
  </dd>
  <dt>node_id</dt>
  <dd>This is the shortname for the web-service that will be used by the
      VO registry.  A good shortname would be something like SDSS or GALEX.  It
      is very important that the shortname match the name you give when
      registering the web-service (more on this later).
  </dd>
  <dt>sigma</dt>
  <dd>Average positional error of objects in the database in arcseconds.  In
      order to get a successful cross-match, this value must be somewhere
      around 10 - 20 arcseconds, even if the error is much smaller.
  </dd>
</dl>

<p>Note that the one key that you should <strong>not</strong> change is
<code>def_portal_url</code>.  This must be set to the primary SkyPortal so
that it can coordinate how to query each SkyNode.  When you run a query
on <a href="http://openskyquery.net">http://openskyquery.net</a>, the
main portal contacts each individual SkyNode, which must know where to send
its response.  This is what this key tells your SkyNode.</p>

<p>Once you have edited <code>web.config</code> properly, the web-service
is almost ready for testing.  There are still some small details to check
before actually testing the web-service.  The next section deals with the
remaining things to sort out.</p>

<h2>5: Odds and Ends</h2>

<p>Well, you're almost done but there are still a few things that you might need
to fix up before your SkyNode will work.</p>

<p>First, the web-service uses SQL authentication (not Windows authentication)
in order to authenticate the public user.  In order for the public user to be
login, you need to be sure to set SQL Server up so that this is possible.</p>

<p>Open up Enterprise Manager and navigate to the local database, then right
click on the name of the machine with your database and select
<code>Properties</code> from the list. Click on the <code>Security</code> tab
and make sure that <code>Authentication</code> is set to <code>SQL Server and
Windows</code>.</p>

<img src="./web/fig7.gif" alt="Database menu" width="683" height="535">
<br><br>
<img src="./web/fig8.gif" alt="Properties box" width="403" height="530">

<h2>6: Testing the SkyNode</h2>

<p>The SkyNode includes two simple web pages that can be used to test the
installation of the SkyNode. These two pages are named <code>default.asmx</code>
and <code>nodeb.asmx</code>. You can access these pages by going to the
following URLs:</p>

<code>
http://&lt;host-name&gt;/&lt;skynode-dir&gt;/default.asmx<br>
http://&lt;host-name&gt;/&lt;skynode-dir&gt;/nodeb.aspx<br>
</code>

<p>The first page is much more useful for testing.  There are 4 buttons at the
bottom of the page, <code>Tables</code>, <code>Columns</code>, 
<code>Sql2ADQL</code>, and <code>Run SQL</code>.  The first two test the
metadata tables in your database.  If they are set up properly, they should
return lists of all of the tables and columns in your database respectively.
The next button, <code>Sql2ADQL</code>, should always work.  The last button,
<code>Run SQL</code>, should perform the query listed in the box (which can't
actually be changed) and return the first 10 entries in the database in XML
format.  If all of these buttons function, then your SkyNode is working
properly.</p>



<h2>7: Registering the SkyNode</h2>

<p> If you are felling brave just go to <a href="http://nvo.stsci.edu/voregistry"> The STSCI/JHU Registry </a> and copy another skynode
entry.
<p> There is a good guide to registering servives with the VirtualObservatory on us-vo.org. <br>
<a href="http://us-vo.org/projects/project.cfm?ID=52">How to publish ot the VO</a>

<h2>8: Troubleshooting</h2>

<p>The following errors will show up when trying out various tests on the
<code>default.asmx</code> page included with the web-service.</p>

<table border="1">
  <tr>
    <td><strong>Error:</strong></td>
    <td><strong>Problem:</strong></td>
    <td><strong>Solution:</strong></td>
  </tr>
  <tr>
    <td>Cannot find table 0</td>
    <td>The public user does not have read permissions for the metadata
        table DBObjects.</td>
    <td>Give the public user read (select) permissions on the metadata
        tables DBObjects, DBColumns, and DBViewCols.  See information about the
        SQL script <code>initUser.sql</code>.</td>
  </tr>
  <tr>
    <td>Server was unable to process request. --&gt; String or binary data would
        be truncated. The statement has been terminated.</td>
    <td>The <code>node_id</code> value in web.config is too long.</td>
    <td>Choose a shorter name.</td>
  </tr>
</table>


<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
