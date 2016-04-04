<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,SDSS Mirrors,mirrors;";
  gutter += "1,DB Download,mirrors/subsets.aspx;";
  gutter += "2,Hardware,mirrors/hardware.aspx;";
  gutter += "3,Website,mirrors/website.aspx;";
//  gutter += "4,SQL Server,mirrors/mssql.aspx;";
//  gutter += "5,FAQ,mirrors/faq.aspx;";
  gutter += "6,Weblog DB,mirrors/weblogdb.aspx;";
  gutter += "7,sqlLoader,mirrors/loader.aspx;";

  string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
