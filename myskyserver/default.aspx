<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - MySkyServer";
	string author ="Maria Nieto-Santisteban, Nolan Li and Ani Thakar";
	string email ="thakar@pha.jhu.edu";
	string cvsRevision = "$Revision: 1.13 $";
	Session["gselect"]=0;	
    string leftMenu = "gutter.aspx";
	string Parameters = "message="+Title+	"&"+"author="+author+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% 
  string url = ConfigurationSettings.AppSettings["url"];
  if (null == url) url="/";
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>MySkyServer is a small subset of the SDSS database that you can use for experimentation or to find out if you have all the necessary pieces in place to hold a larger copy. You will need a Windows Web server and a Microsoft SQL Server database server in order to install and run a personal SkyServer.  Both of these can be the same physica server or be two different servers on a local network.
<h3>MyBestDR7 database</h3>
Click <a href="../arcs/MyBestDR7.zip">here to download the MyBestDR7 database</a>, which is a personal sized (~ 1.5 GB) subset of the BestDR7 database.  You will need to uncompress the downloaded zip file and then restore the MyBestDR7.bak file to a SQL Server database (in SQL Server Management Studio).
<p> 
After the database is restored, create a login (SQL Server user, not Windows user) on that server for the user that the SkyServer Web interface will use to connect to the MyBestDR7 database. You can do this by opening the Security tab at the top level, right-clicking on Logins and selecting "New login...". Select SQL Server authentication for the user and create the userid and password that you will use in the last step below. Your SQL Server will need to be set up in Mixed Authentication Mode (SQL Server and Windows authentication).
<p>
In SQL Server Management Studio, open the MyBestDR7 tab, then open the Security tab, right-click on Users and select "New user" to create a user mapped to the login you just created, and set its default schema to "db_datareader". 
<p>
Again, under the Security tab, open the Schemas tab.  Right-click on Properties for the db_datareader schema, and then select Permissions from the menu on the left.  Click on "Database permissions" on the right, and then select the entry for the user you created above.  In the permissions listed below, click to turn on the following permissions: Select, Execute, Show Plan and View Definition.  Click Ok to save all the changes.
<h3>SkyServer Web Interface</h3>
Please follow the instructions on the <a href="../mirrors/website.aspx"> website download page</a> to download and install the SkyServer website. 
Set the "server" variable in the globals.inc file to the server where you restored the MyBestDR7 database, and set the "userid" and "userpwd" variables to the name and password of the SQL Server login you created above. 
<p>
Once you follow all these steps, you should have a MySkyServer site that points to your own personal-sized subset of the SkyServer DR7 database.
</p
<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
