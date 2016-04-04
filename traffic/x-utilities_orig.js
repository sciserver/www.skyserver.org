<% 
function pad(val) {
    return (val<10)? "0"+val: val;
}

function dmsN(deg) {
	var sign = (deg<0)?'-':'+';
	var deg  = (deg<0)?-deg:deg;
	var dd = Math.floor(deg);
	var qq = 60.0*(deg-dd);
	var mm = Math.floor(qq);
	var ss = Math.floor(600.0 *(qq - mm))/10.;
	return (sign+pad(dd)+pad(mm)+pad(ss))
}

function hmsN(deg) {
	var hh = Math.floor(deg/15.0);
	var qq = 4.0*(deg-15*hh);
	var mm = Math.floor(qq);
	var ss = Math.floor(600.0*(qq-mm))/10.0;
	return (pad(hh)+""+pad(mm)+""+pad(ss));
}

function SDSSname(ra,dec) {
    return "SDSS J"+hmsN(Number(ra))+dmsN(Number(dec));
}


function ccut(name,count,min,max) {
	return ((count==0)?" WHERE ":" AND ")+name+" BETWEEN "+min+" AND "+max;
}



function rangeCheck(name,min,max,lo,hi) {
	if(min > max){
		Response.Write("Minimum "+name+" value must be less than maximum <P>" );
		return true;
		}
	if (max>hi){
		Response.Write("Max "+name+" must be less than "+hi+" <P>");
		return true;
		}
	if (min<lo){
		Response.Write("Min "+name+" must be more than "+lo+"<P>");
		return true;
		}
   if (isNaN(min) || isNaN(max) ) {
		Response.Write("Please enter numerical values for "+name+" min and max.<P>");
		return true;
		}
   return false;
}

function valueCheck(name,val,lo,hi) {
	var err = false;
	if (val>hi){
		Response.Write(name+" must be less than "+hi+" <P>");
		return true;
		}
	if (val<lo){
		Response.Write(name+" must be more than "+lo+"<P>");
		return true;
		}
   if (isNaN(val)) {
		Response.Write("Please enter numerical values for "+name+"<P>");
		return true;
		}
   return false;
}

function hms2deg(s) {
	var a = s.split(':');
	return 15*a[0]+a[1]/4.+a[2]/240.;
}

function dms2deg(s) {
	var a = s.split(':');
	if( s.indexOf("-") == 0 )	
		return -(-1.0*a[0]+a[1]/60.+a[2]/3600.);
	else
		return 1.0*a[0]+a[1]/60.+a[2]/3600.;
	
}
%>

<script RUNAT=SERVER LANGUAGE="VBSCRIPT"> 

     function makeStr(x)
         If IsNull(x.value) Then
			makeStr = "null"
		 Else
			makeStr = CStr(x)
		 End If
     end function

     function makeStrB(x)
		dim i
		makeStrB = ""
		For i=1 to LenB(x)
			makeStrB = makeStrB & Chr(AscB(MidB(x,i,1)))
		Next
     end function

</script>

<% 

function getValue(oRs,i) {
    return stringOf(oRs.fields(i));
}


function toHex(val) {

    var tmp = makeStr(val);
    var length = val.ActualSize;
    
    var hex = "0x";
    var siz = Math.min(length/2, 4);
    for  (var i = 0; i < siz; i++){
        var ch2 = tmp.charCodeAt(i);  // a unicode  char 0...64k
        var c0 = (ch2 & 0x000F);
        var c1 = (ch2 & 0x00F0) >> 4;
        var c2 = (ch2 & 0x0F00) >> 8;
        var c3 = (ch2 & 0xF000) >>12;
        hex +=   c1.toString(16)
               + c0.toString(16)
               + c3.toString(16)
               + c2.toString(16);
        }
    if (length > 8)  hex += "...";    // only show first 8 bytes of long strings.
    return hex;
}


function fmt(num,total,digits) {
    var n = new Number(num);
    if (n==0) return n;
	var exp = Math.floor(Math.log(Math.abs(n))/Math.LN10);
	var scale = Math.pow(10.,digits);
	if (exp<-2 || exp>3) {
		var esc = Math.pow(10.,exp);
		return String(Math.floor(scale*num/esc+0.5)/scale)+"E"+exp;
	}
	if (total>0) 
		scale = Math.pow(10., Math.min(digits,total-exp-1));
	return Math.floor(scale*n+0.5)/scale;
}


function stringOf(result) {
    switch(result.type) {
        case 4:  // float
            return fmt(result,6,3);
        case 5:  // real
            return fmt(result,0,6);
        case 20:   // bigint
            return makeStr(result);
        case 128:  // binary
        case 204:  // varbinary
        case 205:  // image
            return toHex(result);
        case 133:  // datetime
        case 134:  // datetime
        case 135:  // datetime
            return  makeStr(result);
        default:
            return  makeStr(result);
        }
}

//----------------------------------------------
// XML  output
//----------------------------------------------
function writeXML(oCmd, cmd) {

	oCmd.CommandText = cmd;
	var status = "none"; 
	var buffer = Response.Buffer;

	Response.Write('<?xml version="1.0" encoding="UTF-8" ?>');
	Response.Write('<root><Query>' + cmd + ' </Query>');
	Response.Write("<Answer>");
 	try {
		var oRs = oCmd.Execute();
		if (oRs.eof) {
   		    Response.Write("<Row> No rows returned </Row>");
		} 
		else {
	       		var count = 0;
     			while(!oRs.eof) {
				if( !Response.IsClientConnected ) {
					return;
				}
     				Response.Write("<Row ");
     				for(Index=0; Index <(oRs.fields.count); Index++){
     					Response.Write(" " + oRs.fields(Index).name + '="' 
						   + stringOf(oRs.fields(Index)) + '"');					
	       			}
	          		Response.Write(" />");
				oRs.MoveNext();
				if (count++>100) {
					if( Response.IsClientConnected ) {
						count = 0;
						if (buffer) Response.Flush();
					} else {
						return;
					}
				}
	    		}
		}
     	} 
	catch(e) {
		if( Response.IsClientConnected ) {
			Response.Write('<Diagnostic> ' + e.description + '</Diagnostic>');
 			format = "error";
		}
	}
//	oConn.close();  // shutdown 
	Response.Write('</Answer></root>'); 
	if (buffer) 
		Response.Flush();
}	

//----------------------------------------------
// HTML  output
//----------------------------------------------
function writeHTML(oCmd, cmd, echo) {
	oCmd.CommandText = cmd;
	var status = "none"; 
	var buffer = Response.Buffer;

	try	{
		var oRs = oCmd.Execute();
		status = "table";

		Response.Write("<html><head>\n");
		Response.Write("<title>SDSS Query Results</title>\n");
		Response.Write("</head><body bgcolor=white>\n");
		if (echo==1) 
			Response.Write("<h3>Your SQL command was: <br><pre>" + oCmd.CommandText+"</pre></h3><br>"); // writes command

		// start writing table of attributes, if there are any

		if (oRs.eof) {
   		    Response.Write("<h3><br><font color=red>No objects have been found</font> </h3>");
		} else {
   			Response.Write("<table border='1' BGCOLOR=cornsilk>\n");
   			Response.Write("<tr align=center>");
    		for(Index=0; Index <(oRs.fields.count); Index++) {
        		Response.Write("<td><font size=-1>");
				Response.Write(oRs.fields(Index).name);
        		Response.Write("</font></td>");
        		}
			Response.Write("</tr>\n");
		
			// writes line for each object
			
		if( !Response.IsClientConnected ) {
			return;
		}
       		var count = 0;
     		while(!oRs.eof) {
     			Response.Write("<tr align=center BGCOLOR=#eeeeff>");
     			for(Index=0; Index <(oRs.fields.count); Index++){
					//var res = oRs.fields.item(Index);
					var res = oRs.fields(Index);
       	   			Response.Write("<td nowrap><font size=-1>" + stringOf(res) +"</font></td>");
           		}
          		Response.Write("</tr>\n");
			oRs.MoveNext();
			if (count++>100) {
				if( Response.IsClientConnected ) {
					count = 0;
					if (buffer) Response.Flush();
				} else {
					return;
				}
			}
    		}
	   		Response.Write("</TABLE>");
     	}
		Response.Write("</BODY></HTML>\n");
		oRs.close();
	} 
	catch(e) {	
		if( Response.IsClientConnected ) {
			if (status == "none") {
				Response.Write("<HTML><HEAD>\n");
				Response.Write("<TITLE>SQL Statement Error</TITLE>\n");
				Response.Write("</HEAD><BODY BGCOLOR=pink>\n");
				Response.Write("<H3>Your SQL command was: <BR><PRE>" + oCmd.CommandText+"</PRE></H3><P>"); // writes command
 			} else { 
 				Response.Write("</td></tr></table>");
 			}
 			Response.Write("<H3 BGCOLOR=pink>SQL returned the following error: <br>     " + e.description);
 			Response.Write("</H3></BODY></HTML>\n");
 			format = "error";
		}
 	}
//	oConn.close();  // shutdown 
	if (buffer) 
		Response.Flush();
}

//----------------------------------------------
// CSV  output
//----------------------------------------------
function writeCSV(oCmd, cmd) {

	oCmd.CommandText = cmd;
	var status = "none"; 
	var buffer = Response.Buffer;

	try	{
		var oRs = oCmd.Execute();
		status = "table";
		if (oRs.eof) {
    			Response.Write("No objects have been found");
    		} else {
   			for(Index=0; Index <(oRs.fields.count); Index++) {
       				Response.Write(oRs.fields(Index).name);
				Response.Write((Index != oRs.fields.count-1)?",":"\n");
       			}
			if( !Response.IsClientConnected ) {
				return;
			}
       			var count = 0;
     			while(!oRs.eof) {
     				for(Index=0; Index <(oRs.fields.count); Index++){
        				Response.Write(stringOf(oRs.fields(Index)));
					Response.Write((Index != oRs.fields.count-1)?",":"\n");
           			}
				oRs.MoveNext();
				if (count++>100) {
					if( Response.IsClientConnected ) {
						count = 0;
						if (buffer) Response.Flush();
					} else {
						return;
					}
				}
    			}
		}
		oRs.close();
	} 
	catch(e) {	
		if( Response.IsClientConnected ) {
			Response.Write("ERROR\n\nSQL returned the following error message:\n" + e.description+"\n");
			Response.Write("Your SQL command was:\n" + oCmd.CommandText+"\n");
 			format = "error";
		}
 	}
//	oConn.close();  // shutdown 
	if (buffer) 
		Response.Flush();
}


function writeOutput( oCmd, cmd, fmt) {
	if( Response.IsClientConnected ) {
		if (fmt == "xml")  writeXML(oCmd,cmd);
		if (fmt == "html") writeHTML(oCmd,cmd,1);
		if (fmt == "csv")  writeCSV(oCmd,cmd);
	} else {
		oConn.close();
	}
}



%>
