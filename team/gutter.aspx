<%@ Page language="c#" AutoEventWireup="false" %>
<% 

  string gutter = "0,Team,team;";
  gutter += "1,T. Budavari,team/pici.aspx?pic=tamas.jpg&gselect=1&cap= Tamas Budavari;";
  gutter += "13,G. Fekete,team/pici.aspx?pic=george.jpg&gselect=13&cap=George Fekete;";
  gutter += "2,V. Haridas,team/pici.aspx?pic=vivek.jpg&gselect=2&cap=Vivek Haridas;";
  gutter += "3,S. Carlilies,team/pici.aspx?pic=sam.jpg&gselect=3&cap=Sam Carlilies;";
  gutter += "4,N. Li,team/pici.aspx?pic=nolan.jpg&gselect=4&cap=Nolan Li;";
  gutter += "5,M. Nieto,team/pici.aspx?pic=maria.jpg&gselect=5&cap=Maria Nieto-Santisteban;";
  gutter += "6,T. Malik,team/pici.aspx?pic=tanu.jpg&gselect=6&cap=Tanu Malik;";
  gutter += "7,W. O'Mullane,team/pici.aspx?pic=wil.jpg&gselect=7&cap=William O'Mullane;";
  gutter += "8,A. Pope,team/pici.aspx?pic=adrian.jpg&gselect=8&cap=Adrian Pope;";
  gutter += "9,J. Raddick,team/pici.aspx?pic=jordan.jpg&gselect=8&cap=Adrian Pope;";
  gutter += "10,A. Szalay,team/pici.aspx?pic=alex.jpg&gselect=9&cap= Alex Szalay;";
  gutter += "11,A. Thakar,team/pici.aspx?pic=ani.jpg&gselect=10&cap=Ani Thakar;";
  gutter += "12,J. van den Berg,team/pici.aspx?pic=jan.jpg&gslect=11&cap=Jan van den Berg;";

  string pars="gutter="+gutter;
  Session["gutter"]=gutter;
  string pbase = Request.ApplicationPath;

  Server.Execute(pbase+"/makegutter.aspx?"+pars);
 
%>
