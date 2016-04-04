<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,MySkyServer,myskyserver;";
//  gutter += "1,Database,myskyserver/database.aspx;";
//  gutter += "2,WebSite,myskyserver/website.aspx;";
//  gutter += "3,ImgCutOut,myskyserver/ImgCutOut.aspx;";

  string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
