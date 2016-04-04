<%@ Import Namespace="System.Web" %>
<%@ Page language="c#" %>
<!-- #include file="../contact.inc" -->
<% // fill this with your details 
	string Title = "SkyServer";
	string cvsRevision = "$Revision: 1.4 $";
	Session["gselect"]=0;	
	string Parameters = "message="	+Title+"&author="+author+"&leftMenu=gutter.aspx"+
		"&email="+email+"&cvsRevision=" + cvsRevision.Replace(":"," ");
%>


<% 
  Server.Execute("../SkyHeader.aspx" + "?" + Parameters);
%>	
<p>This portion of the site is intended to aid you in the construction of SkyNodes.
<br>We also wish to make available delta downloads for th SkyServer from here.

<p> 
<p> 
<p> Mainly we have SkyNode Instructions for now
<p> 
<br>
<br><br>



<%	Server.Execute("../SkyFooter.aspx" + "?" + Parameters);
%>
