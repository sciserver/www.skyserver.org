<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,CasJobs,casjobs;";
  gutter += "1,CasJobs download,arcs/CasJobs_v4_0_0a.zip;";
   string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
