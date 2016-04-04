<%  @ LANGUAGE="JScript" %>
<!------------#include file="../access.inc"-------->
<% 
    var depth;
	function getURL() {
		var host = Request.ServerVariables("SERVER_NAME");	
		var path = Request.ServerVariables("SCRIPT_NAME");

		var root = "http://"+host;
		var s = new String(path);
		var q = s.split("/");

		var lang="";
		for (var i=0; i<q.length;i++) {
			if(i>0) root += "/";
			root += q[i];
			lang = q[i];
			if (lang=="en" || lang=="de" || lang=="jp" || lang=="fr") {
				depth = q.length - i -2;
				return root;
			}
		}
		return root;
	}
	var url = getURL();
%>
<html>
<head>
<link href="<%=url%>/skyserver.css" rel="stylesheet" type="text/css">
<link rel="SHORTCUT ICON" href="<%=url%>/FavIcon.ICO">


