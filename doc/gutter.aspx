<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,Documentation,documentation;";
  gutter += "1,Sitemap ,doc/sitemap.aspx;";
  gutter += "2,CAS Overview,doc/CASoverview.pdf;";
  gutter += "3,CAS Loader User Guide,help/sqlLoader.htm;";
  string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
