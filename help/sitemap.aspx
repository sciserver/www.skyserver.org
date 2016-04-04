<%@ Page language="c#" Debug="true" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "Site Map";
	string cvsRevision = "$Revision: 1.4 $";
	Session["gselect"]=1;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<pre>
<%	Server.Execute("sitemap.txt"); %>
</pre>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
