<%  @ LANGUAGE="JScript" %>
<% 
//---------------------------------------------------------------
// support multilingual branching at the top level
// the lang attribute determines the language hereafter
// It can take the values "en","de","fr","jp"
//---------------------------------------------------------------	
	
//*****************************************************
	var defaultlanguage = "en";
//*****************************************************

	var host = Request.ServerVariables("HTTP_HOST");
	var path = Request.ServerVariables("SCRIPT_NAME");
	var qry = Request.ServerVariables("QUERY_STRING");
	var url  = "http://"+host;
	Response.Write("host="+host+", qry="+qry);
	
	var s = new String(path);
	var q = s.split("/");
	for(var i=0;i<q.length-1;i++)
		url += q[i]+"/";

	var lang = "";

	// first check for a single lang attribute in the url
	// if it exists, get its value
		
	if (Request.QueryString.Count==1 && Request.QueryString.Key(1)=="lang")
		lang = Request.QueryString("lang");
	
	// set default language, if all fails
	
	if (lang!="en" && lang!="de" && lang!="jp" && lang!="fr")
		lang = defaultlanguage;

	url += lang+"/traffic/";	

	// redirect to the appropriate branch
	Response.Write(url);
%>
