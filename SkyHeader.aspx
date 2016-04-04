<%@ Page language="c#" AutoEventWireup="false" %>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.IO"%>

<HEAD>
<%
	string url =Request.Url.GetLeftPart(System.UriPartial.Authority)+Request.ApplicationPath+"/"; 
	string message = Request.Params["message"];
	if (null == message)  message = "SkyServer.org WebSite";
	string leftMenu = Request.Params["leftMenu"];

%>	
	<title><%=message%></title>
	<LINK href="<%=url%>styles.css" rel="stylesheet">
</HEAD>
<body>
<script type="text/javascript">
var ns = (navigator.appName.indexOf("Netscape") != -1);
var d = document;
var px = document.layers ? "" : "px";
function JSFX_FloatDiv(id, sx, sy)
{
	var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];
	window[id + "_obj"] = el;
	if(d.layers)el.style=el;
	el.cx = el.sx = sx;el.cy = el.sy = sy;
	el.sP=function(x,y){this.style.left=x+px;this.style.top=y+px;};
	el.flt=function()
	{
		var pX, pY;
		pX = (this.sx >= 0) ? 0 : ns ? innerWidth : 
		document.documentElement && document.documentElement.clientWidth ? 
		document.documentElement.clientWidth : document.body.clientWidth;
		pY = ns ? pageYOffset : document.documentElement && document.documentElement.scrollTop ? 
		document.documentElement.scrollTop : document.body.scrollTop;
		if(this.sy<0) 
		pY += ns ? innerHeight : document.documentElement && document.documentElement.clientHeight ? 
		document.documentElement.clientHeight : document.body.clientHeight;
		this.cx += (pX + this.sx - this.cx)/8;this.cy += (pY + this.sy - this.cy)/8;
		this.sP(this.cx, this.cy);
		setTimeout(this.id + "_obj.flt()", 40);
	}
	return el;
}
</script>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr> <td>
	<table background="<%=url%>img/new_home_bktile.jpg" border="0" cellspacing="1" cellpadding="0" 
		width="100%" bordercolor="#FFFFFF">
	  <tr>
			<td height="73">
				<img border="0" src="<%=url%>img/newsdsslogo.png" >
				<img border="0" src="<%=url%>img/titlebar.jpg" >
			</td>		
			<td height="73" width="*">
			</td>
			
	  </tr>
	<tr> <td> <table>
		<tr height="23" bgcolor="#313131">
 			<td width="1" bgcolor="#000000"><img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td> 
			<td nowrap class="navlink" align="center" width="50"><a class="navlink"  href="<%=url%>default.aspx">Home</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="100"><a class="navlink"  href="<%=url%>mirrors">SDSS Mirrors</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

<!--
			<td nowrap class="navlink" align="center" width="90"><a class="navlink"  href="<%=url%>myskyserver">MySkyServer</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

			<td nowrap class="navlink" align="center" width="80"><a class="navlink"  href="<%=url%>buildyourown">SkyNodes</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="70"><a class="navlink"  href="<%=url%>regions">Regions </a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>
-->
			<td nowrap class="navlink" align="center" width="90"><a class="navlink"  href="<%=url%>doc">Documentation</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="50"><a class="navlink"  href="<%=url%>HTM">HTM </a></td>
 			
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="70"><a class="navlink"  href="<%=url%>cfunbase">CfunBASE</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

			<td nowrap class="navlink" align="center" width="70"><a class="navlink"  href="http://skyserver.sdss.org/">SkyServer</a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="70"><a class="navlink"  href="<%=url%>casjobs">CasJobs </a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="70"><a class="navlink"  href="<%=url%>help">Help </a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>

 			<td nowrap class="navlink" align="center" width="50"><a class="navlink"  href="<%=url%>team">Team </a></td>
			<td width="1" bgcolor="#000000"> <img width="1" src="img/new_1px_trans.gif" height="1" height="23" /></td>
	  </tr> </table>
</td></tr>
	</table>
	</td></tr>
	<tr><td height="5"></td></tr>
<tr> <td><table width="800" border="0" cellpading="5">
	  <tr> 
<%if (null != leftMenu) { %>
	<td>&nbsp;</td>
<%}%>
	<td  align="left" > <p class="title"> <%=message%> </p> </td> </tr>
	<tr><td height="3"></td></tr>
<tr>
<%if (null != leftMenu) { 
	// pull in left menu if there is one
%>
	
<td > 
<table width=150><tr><td>
<div id="divTopLeft"     style="position:absolute" >
<%
Server.Execute(leftMenu);
%>
</div>
<script>JSFX_FloatDiv("divTopLeft",  10,   170).flt();</script>
</td></tr></table>
</td> 

<%}%>


<td width="680"> <!-- Page will go in here -->
