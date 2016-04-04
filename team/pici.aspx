<%@ Page language="c#" %>
<% 
	string pic = Request.Params["pic"];
	Session["pic"] = pic;
	string gsel = Request.Params["gselect"];
	Session["gselect"] = gsel;
	string cap = Request.Params["cap"];
	Session["cap"] = cap;
	Response.Redirect("pic.aspx");

%>
