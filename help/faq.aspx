<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer.org - FAQ";
	string cvsRevision = "$Revision: 1.4 $";
	Session["gselect"]=2;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<!-- Your HTML or ASPX here --->
<h2>Frequently Asked Questions  </h2>

We are working on the FAQ at this time.
<p>
Please check this page again in the near future.
<p>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
