<%@ Import Namespace="System.IO" %>
<%@ Page language="c#" AutoEventWireup="false" %>
<%
	string author = Request.Params["author"];
	string email = Request.Params["email"];
	string cvsRevision = Request.Params["cvsRevision"];
	
	string page = Request.Params["PATH_TRANSLATED"];

	
	string  htmlRevision = "??";
	
	if(null != page)
	{
		FileInfo f = new FileInfo(page);
		htmlRevision = f.LastWriteTime.ToLongDateString() + " at " + f.LastWriteTime.ToLongTimeString();
	}



	
	if(null == author)	author = "";
	if(null == email)  email = "";
	if(null == cvsRevision)  cvsRevision = "$$";

	
%>

</td></tr>
</table>
<tr><td>
<hr/>
<p class="tiny">
	<a href="mailto:<%=email%>">
	<%=author%>
	</a>	
	<br/>
	Last Modified :<%=htmlRevision%>
	, <%=cvsRevision%>	
</p>
</td></tr>
</table>
</body>