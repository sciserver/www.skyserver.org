<%@ Page language="c#" Debug="true"%>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServerOrg - Help";
	string cvsRevision = "$Revision: 1.5 $";
	Session["gselect"]=0;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<h2>Help   </h2>
The main parts of the site are navigable from the  menu on the top of the screen.
Each root menu will take you to a section of the site if clicked upon. In most places you will also have 
a left menu of sub topics. 

<p>You can look at the <a href="sqlLoader.htm">CAS Loader User Guide</a> for instructions on how to set up
components of your CAS (SkyServer) mirror site.

<p>
There is also a <a href="sitemap.aspx">sitemap </a> outlining the structure of the site.
</p>

<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
