<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "MySkyServer WebSite";
	string author ="Maria Nieto-Santisteban";
	string email ="nieto@pha.jhu.edu";
	string cvsRevision = "$Revision: 1.5 $";
	Session["gselect"]=3;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  string url = ConfigurationSettings.AppSettings["url"];
  if (null == url) url="/";
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<pre>
/******************************************************
     How to Create the ImageCutout Web application 
     for the Sloan Digital Sky Survey Database 
     
Updates can be downloaded from: www.skyserver.org/myskyserver/
*******************************************************/
System Requirements:     Windows 2000/XP/20003
                         IIS
                         
*******************************************************/

0 - Install MyBestDR3 database. Follow directions described 
    in ReadmeBeforeInstallMyBestDr3.txt.

1 - Unzip the file and extract all files to ImgCutoutSource.

2 - From Visual Studio, create a new project called ImgCutout 
(be sure your World Wide Web Publishing Service is started)
	
	2.1 File -> New Project

	2.2 Select C# ASP.NET Web Application 
	
		location://localhost/ImgCutout

	by default it will locate the project in  c:\inetpub\wwwroot\ImgCutout

	2.3 Select and delete WebForm1.aspx (you don't need it)

3 - Create the ImgCutout WebService

	3.1 Right button selection on top of project name.
	3.2 Select Add Web Service.
	3.3 Call the service ImgCutout.asmx
	3.4 Close the window  ImgCutout.asmx.cs [Design]

4 - Go to the directory ImgCutoutSource, select all the files *.cs and GetJepeg.aspx, 
    copy and paste them into the project solution explorer area. It works great! 
    (Web.config is there for you to compare how it looks like currently)

	4.1 It will tell you that ImgCutout.asmx.cs already exists. 

	 - Click YES. Replace it.

	4.2 It will tell you that GetJpeg.aspx doesn't have a class file associated.

	 - Click NO. You don't need to create one.

	4.3 If you didn't close the design view of ImgCutout, then you probably will 
	    have another message with something about some file has been loaded outside 
	    the editor.

	 - Click YES.

5 - Select the file ImgCutout.asmx, click the right button and select "Set as Start Page".

6 - Add Microsoft.Web.Services references 
    (If you don't have them comment the DimeJpeg method in Imgcutout.asmx.cs)

7 - Build your application. (Build in top menu) 
	When building it will say the code is unsafe when building the first time.

To change this:

	7.1 Right button on top of project name.
	7.2 Select Properties.
	7.3 Select Configuration Properties.
	7.4 Set up "Allow Unsafe Code Blocks" to TRUE.

8 - Open the Web.config file and add below </system.web>:

 <appSettings>
    <add key="SkyServer" value="Initial Catalog=MyBestDR3;Data Source=(local);User ID=Internet;Password=xxxxxxxx" />
    <add key="DataRelease" value="DR3" />
  </appSettings>

The usual password for the Internet user is xxxxxxxx. You will need to write here your own Internet 
user's password if it is different

9 - The application should be ready to run. Be sure your MSSQLSERVER service is started (green arrow).

Try:
http://localhost/ImgCutout/GetJpeg.aspx?ra=195&dec=2.5&scale=0.2&width=200&height=200&opt=G

</pre>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
