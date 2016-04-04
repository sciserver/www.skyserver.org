<!--begin header-->
<%
	var refURL = String( Request.ServerVariables("HTTP_REFERER") );
	if( refURL == "undefined" )
		wurl = "../../../dr1/en/";
	else
		wurl = Request.ServerVariables("HTTP_REFERER");
%>
<div id="div_title">
<table background="<%=imgpath%>/new_home_bktile.jpg" cellpadding="0" cellspacing="0" border="0" width="100%" height="73"> 
  <tr height="73" width="50">
    <td align="left" height="73"  width="800">
	<a href="http://www.sdss.org"><img class="imgnoborder" src="<%=imgpath%>/sdss_logo_73.gif" width="50"></a><img src="<%=imgpath%>/titlebar.gif" width="750" height="73"></td>
    <td height="73" width="*"></td>
  </tr>
</table>  
</div>
<div id="div_nav">
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="25"> 
  <tr height="1" bgcolor="#000000">
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    <td width="70" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    <td width="70" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
		<td width="100" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
		<td width="105" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    <td width="70" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
		<td width="100" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
	  <td width="65" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
	  <td width="65" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
	  <td width="60" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    
    <td width="1" bgcolor="#000000"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>
    <td width="*" height="1"><img width="1" src="<%=imgpath%>/new_1px_trans.gif" height="1"></td>

  </tr>    
  <tr height="23" bgcolor="#313131">
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td class="navlink" align="center" width="70"><a class="navlink" href="<%=wurl%>" target="_top">&nbsp;&nbsp;Home&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="70"><a class="navlink" href="<%=wurl%>tools/" target="_top">&nbsp;&nbsp;&nbsp;&nbsp;Tools&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="100"><a class="navlink" href="<%=wurl%>proj/" target="_top">&nbsp;&nbsp;&nbsp;&nbsp;Projects&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="105"><a class="navlink" href="<%=wurl%>astro/" target="_top">&nbsp;&nbsp;&nbsp;Astronomy&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="70"><a class="navlink" href="<%=wurl%>sdss/" target="_top">&nbsp;&nbsp;&nbsp;SDSS&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>    
    <td nowrap class="navlink" align="center" width="100"><a class="navlink" href="<%=wurl%>skyserver/" target="_top">&nbsp;&nbsp;&nbsp;SkyServer&nbsp;&nbsp;&nbsp;</a></td>    
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>    
    <td class="navlink" align="center" width="70"><a class="navlink" href="<%=wurl%>credits/" target="_top">&nbsp;&nbsp;&nbsp;Credits&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="90"><a class="navlink" href="<%=wurl%>help/download/" target="_top">&nbsp;&nbsp;&nbsp;Download&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td nowrap class="navlink" align="center" width="65"><a class="navlink" href="<%=wurl%>help/" target="_top">&nbsp;&nbsp;&nbsp;Help&nbsp;&nbsp;&nbsp;</a></td>
    
    <td width="1" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="1" height="23"></td>
    <td width="*">&nbsp;</td>
  </tr>
  
  <tr height="1" bgcolor="#000000">
		<td height="1" colspan="20" bgcolor="#000000"><img src="<%=imgpath%>/new_1px_trans.gif" width="100%" height="1"></td></td>
  </tr>  
</table>
</div>
<!--end header-->
