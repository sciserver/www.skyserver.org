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

function dmsPad(deg) {
	var sign = (deg<0)?'-':'+';
	var deg  = (deg<0)?-deg:deg;
	var dd = Math.floor(deg);
	var qq = 60.0*(deg-dd);
	var mm = Math.floor(qq);
	var ss = Math.floor(600.0 *(qq - mm))/10.;
	return (sign+pad(dd)+" "+pad(mm)+" "+pad(ss))
}

function hmsPad(deg) {
	var hh = Math.floor(deg/15.0);
	var qq = 4.0*(deg-15*hh);
	var mm = Math.floor(qq);
	var ss = Math.floor(600.0*(qq-mm))/10.0;
	return (pad(hh)+" "+pad(mm)+" "+pad(ss));
}

function dmsIAU(deg) {
	var sign = (deg<0)?'-':'+';
	var deg  = (deg<0)?-deg:deg;
	var dd = Math.floor(deg);
	var qq = 60.0*(deg-dd);
	var mm = Math.floor(qq);
	var ss = Math.floor(600.0 *(qq - mm))/10.;
	return (sign+pad(dd)+pad(mm)+pad(ss.toFixed(1)))
}

function hmsIAU(deg) {
	var hh = Math.floor(deg/15.0);
	var qq = 4.0*(deg-15*hh);
	var mm = Math.floor(qq);
	var ss = Math.floor(6000.0*(qq-mm))/100.0;
	return (pad(hh)+""+pad(mm)+""+pad(ss.toFixed(2)));
}

function SDSSname(ra,dec) {
    return "SDSS J"+hmsIAU(Number(ra))+dmsIAU(Number(dec));
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

// hms2deg and dms2deg have been copied to ctrlscript.inc in the tools/chart directory.
// if a change is required in this piece of code, it should be propagated to tools/chart/// ctrlscript.inc
// at least until I find out how to include the file in ctrlscript.inc
//------------------------------------

function hms2deg(s,c) {
	var numargs = arguments.length;
	if( numargs < 2 )
		c = ':'; 
	// strip leading blanks or plus signs first
	while( s.length > 0 && (s.substring(0,1)==' ' || s.substring(0,1)=='+') )
		s = s.substring(1);
	var a = s.split(c);
	return 15*a[0]+a[1]/4.+a[2]/240.;
}

function dms2deg(s,c) {
	var numargs = arguments.length;
	if( numargs < 2 )
		c = ':'; 
	// strip leading blanks or plus signs first
	while( s.length > 0 && (s.substring(0,1)==' ' || s.substring(0,1)=='+') )
		s = s.substring(1);
	var a = s.split(c);
	if( s.indexOf("-") == 0 )	
		return -(-1.0*a[0]+a[1]/60.+a[2]/3600.);
	else
		return 1.0*a[0]+a[1]/60.+a[2]/3600.;
}
	

function parseRA(s_ra) {
	var v;
	if (s_ra.lastIndexOf(":") > -1) {
		v = fmt(hms2deg(s_ra,':'), 10, 5);
	} else {
		if( s_ra.search(/\d \d/) > -1 ) {
			v = fmt(hms2deg(s_ra,' '), 10, 5);
		} else {
			v = parseFloat(s_ra);
			if(isNaN(v)) v=180.0;
			if (v<0) v+= 360;
			if (v>360) v-= 360;
		}
	}
	return v;
}

function parseDec(s_dec) {
	var v;
	if (s_dec.lastIndexOf(":") > -1) {
		v = fmt(dms2deg(s_dec,':'), 10, 5);
	} else {
		if( s_dec.search(/\d \d/) > -1 ) {
			v = fmt(dms2deg(s_dec,' '), 10, 5);
		} else {
			v = parseFloat(s_dec);
			if(isNaN(v)) v=0.0;
			if (v<-90) v= -90;
			if (v>90) v= 90;
		}
	}
	return v;
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
        case 4:  // real - single precision
            return fmt(result,9,6);	// up to 9 digits wide, with 6 decimal places
        case 5:  // float - double precision
            return fmt(result,0,8);	// as wide as it needs to be, with 8 decimal places
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
function writeXML(oCmd, cmd, cmd_echo) {

	oCmd.CommandText = cmd;
	var status = "none"; 
	var buffer = Response.Buffer;

	Response.Write('<?xml version="1.0" encoding="UTF-8" ?>');
	Response.Write('<root><Query>' + cmd_echo + ' </Query>');
	Response.Write("<Answer>");
	Response.Flush();
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
function writeHTML(oCmd, cmd, cmd_echo, echo) {
	oCmd.CommandText = cmd;
	var status = "none"; 
	var buffer = Response.Buffer;

	try	{
		status = "table";
		Response.ContentType = "text/HTML";
		Response.Flush;
		Response.Write("<html><head>\n");
		Response.Write("<title>SDSS Query Results</title>\n");
		Response.Write("</head><body bgcolor=white>\n");
		if (echo==1) 
			Response.Write("<h3>Your SQL command was: <br><pre>" + cmd_echo + "</pre></h3>"); // writes command
		Response.Flush;

		var oRs = oCmd.Execute();

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
			if( !Response.IsClientConnected ) {
				return;
			} else {
				Response.Flush();
			}
		
			// writes line for each object
			
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
				Response.Write("<H3>Your SQL command was: <BR><PRE>" + cmd_echo+"</PRE></H3>"); // writes command
 			} else { 
 				Response.Write("</td></tr></table>");
 			}
 			Response.Write("<H3 BGCOLOR=pink><font color=red>SQL returned the following error: <br>     " + e.description);
 			Response.Write("</font></H3></BODY></HTML>\n");
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
		status = "table";
        	Response.ContentType = "application/text";
		Response.AddHeader("Content-Disposition","attachment;filename=\"result.csv\"");
		var oRs = oCmd.Execute();
		if (oRs.eof) {
    			Response.Write("No objects have been found");
    		} else {
   			for(Index=0; Index <(oRs.fields.count); Index++) {
       				Response.Write(oRs.fields(Index).name);
				Response.Write((Index != oRs.fields.count-1)? ",":"\n");
       			}
			if( !Response.IsClientConnected ) {
				return;
			} else {
				Response.Flush();
			}
       			var count = 0;
     			while(!oRs.eof) {
     				for(Index=0; Index <(oRs.fields.count); Index++){
					var type = oRs.fields(Index).type;
					var str = stringOf( oRs.fields(Index) );
					if( (type == 200 || type == 201) && (str.indexOf(",") != -1) && (str.charAt(0) != '"') ) {
					        str.replace(/"([^"]*)"/g, "``$1''");
						Response.Write("\""+str+"\"");
					} else { 
        					Response.Write(str);
					}
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



//----------------------------------------------
// HTML  message
//----------------------------------------------
function writeSyntaxMessage(oCmd, cmd, cmd_echo) {
	oCmd.CommandText = cmd;
	var buffer = Response.Buffer;

	try	{
		Response.ContentType = "text/HTML";
		Response.Flush;
		Response.Write("<html><head>\n");
		Response.Write("<title>SDSS Query Syntax Check</title>\n");
		Response.Write("</head><body bgcolor=white>\n");
		Response.Write("<h2>SQL Syntax Check</h2>");

		var oRs = oCmd.Execute();

		// write out message
		Response.Write("<H3> <font color=green>" + stringOf(oRs.fields(0)) + "</font></H3></BODY></HTML>\n");

	} 
	catch(e) {	
		if( Response.IsClientConnected ) {
 			Response.Write("<H3 BGCOLOR=pink><font color=red>SQL returned the following error: <br>     " + e.description);
 			Response.Write("</font></H3></BODY></HTML>\n");
 			format = "error";
		}
 	}
	Response.Write("<h3>Your SQL command was: <br><pre>" + cmd_echo + "</pre></h3><hr>"); // writes command
	Response.Flush;
//	oConn.close();  // shutdown 
	if (buffer) 
		Response.Flush();
}

function writeOutput( oCmd, cmd, cmd_echo, fmt) {
	if( Response.IsClientConnected ) {
		if (fmt == "xml")  writeXML(oCmd, cmd, cmd_echo);
		if (fmt == "html") writeHTML(oCmd, cmd, cmd_echo, 1);
		if (fmt == "csv")  writeCSV(oCmd, cmd);
	} else {
		oConn.close();
	}
}



%>