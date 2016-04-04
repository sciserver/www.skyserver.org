<%@ Page language="c#" AutoEventWireup="false" %>
<% 
/* No gutter in future *
  string gutter = "0,HTM,htm;";
  gutter += "1,Documentation,htm/doc;";
  gutter += "1.1,Overview,htm/doc/intro.aspx;";
  gutter += "1.2,Construction,htm/doc/constr.aspx;";
  gutter += "1.3,Geomerty,htm/doc/geometry.aspx;";
  gutter += "1.4,User Guide,htm/doc/userguide.aspx;";
  gutter += "1.5,Prog Guide,htm/doc/progguide.aspx;";
  gutter += "2,Implementation ,htm/implementation.aspx;";
  gutter += "3,Platforms,htm/platforms.aspx;";
  string pars="gutter="+gutter;
 * */
    string gutter = "";
    string pars = "gutter=" + gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
