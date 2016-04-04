<%@ Page language="c#" %>
<% // fill this with your details 
	string Title = "SkyServer.org - "+Session["cap"];
	string author ="William O'Mullane";
	string email ="womullan@jhu.edu";
	string cvsRevision = "$Revision: 1.3 $";
	string leftMenu = "gutter.aspx";
	string Parameters = "message="+Title+	"&"+"author="+author+
		"&"	+"email="+email	+"&"+"cvsRevision=" + cvsRevision.Replace(":"," ") +
		"&leftMenu="+leftMenu;
//  	Session["gselect"]=0;

%>
<% // will need to fix path if we have sub dirs .. 
	Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
	string pic = Request.Params["pic"];
	if (null == pic) {
		pic = (string)Session["pic"];
	}

%>

<img src="<%=pic%>"> 

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);%>