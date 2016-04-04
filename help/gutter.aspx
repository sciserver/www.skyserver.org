<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,Help,help;";
  gutter += "1,Sitemap ,help/sitemap.aspx;";
  gutter += "2,FAQ,help/faq.aspx;";
  gutter += "3,CAS Loader User Guide,help/sqlLoader.htm;";
  string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
