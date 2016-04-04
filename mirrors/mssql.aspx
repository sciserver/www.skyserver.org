<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "Microsoft SQL Server Licences";
	string author ="Ani R Thakar";
	string email ="thakar@jhu.edu";
	string cvsRevision = "$Revision: 1.4 $";
	Session["gselect"]=4;	
	string leftMenu = "gutter.aspx";
	string Parameters = "message="	+	Title	+	"&"	+	"author="	+	author	+
		"&"	+	"email="	+	email	+	"&"	+	"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
%>


<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>
<p>
For personal use (MySkyServer), there is something called SQL Server Express.  
It is a free version of SQLserver  (the engine and most of the tools but not including 
the data mining stuff).  It is all (and more) than you need for SDSS query work. 
And it is free for development ("personal and non-commercial") use -- just download it and use it:  
<p>
<dd><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=220549b5-0b07-4448-8848-dcc397514b41&DisplayLang=en
">The SQL Server 2005 Express download site</a>

<p>
There is also a freely downloadable copy of SQL server for personal use. It
is a 120 day evaluation copy. Once it expires, you can just run it again, and its
another 120 days.  This can be found at:
<p>
<dd><a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=6931fa7f-c094-49a2-a050-2d07993566ec&DisplayLang=en
">The SQL Server 2005 Enterprise Evaluation copy download site</a>

<p>
For academic institutions, the best bet is the <a href="http://msdn.microsoft.com/academic/">MSDN Academic Alliance</a>. It actually licenses 
a single department rather than the entire institution. It's usually under $1000 for starters, and then about half that per year 
to renew. It licenses the department to use just about all MS server apps and platforms for teaching and research purposes.

<p>If you have any difficulty in obtaining a copy of SQL Server for academic use, please <a href="mailto:<%=email%>">contact us</a>.

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
