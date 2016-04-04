<%@ Page language="c#" AutoEventWireup="false" %>
<% 
  string url = ConfigurationSettings.AppSettings["url"];
  if (null == url) url="/";

  string gutter = "0,Build Your Own,buildyourown;";
  gutter += "1,Open SkyNode ,skynode/openskynode.aspx;";
  gutter += "2,SkyNode,skynode;";
  string pars="gutter="+gutter;
  Session["gutter"]=gutter; 
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);

 
%>
