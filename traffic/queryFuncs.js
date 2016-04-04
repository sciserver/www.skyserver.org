<%
//##################################################################//
//																	//
// Various javascript functions for the query tools (IQS/SQS)       //
//																	//
//##################################################################//

//---------------------------------------
// SQL related functions
//---------------------------------------	

function insertLine(oRs, row, n, line) {
	var v = line.split(reSplitList);
	if( dbg == 1 ) showLine( "row: "+v );
	if( v.length > 2 ) {
		oRs.Addnew();
		oRs("up_id") = row;
		v[0] = v[0].replace(/\s+/g,":");
		v[1] = v[1].replace(/\s+/g,":");
		if( v[0].indexOf(":") >= 0 ) v[0] = hms2deg(v[0]);
		if( v[1].indexOf(":") >= 0 ) v[1] = dms2deg(v[1]);
		for (var i=0;i<n.length;i++)
			oRs("up_"+n[i]).Value = v[i];
		if (dbg==1) showLine(" row "+row+"--"+v+" =>#upload");
	}
}


function showTable(oCmd, cmd) {

		
	var c = cmd;
	var cmd_echo = cmd;
	
        c = String(c).replace(new RegExp("'","g"),"''"); 
	var nw = new ActiveXObject("WScript.Network");
	var windows_name = nw.ComputerName;
	var server_name = Request.ServerVariables("SERVER_NAME");
	var remote_addr = Request.ServerVariables("REMOTE_ADDR");
	var cmd = "EXEC spExecuteSQL '" + c +"  ', " + rowLimit + ",'" + server_name + "','" + windows_name + "','" + remote_addr + "','" + access + "'" ;

	
	oConn.CommandTimeout = formTimeout;
	oCmd.CommandTimeout = formTimeout;
	Server.ScriptTimeout = formTimeout;
	
	if (dbg==1) 
		showLine(cmd+"\n");
	if (f.format.value=="html")		 
		writeHTML(oCmd,cmd,cmd_echo,1);
	else if (f.format.value=="xml")  writeXML(oCmd,cmd);
	else if (f.format.value=="csv")  writeCSV(oCmd,cmd);
}


function addField(f, n) {					// add field 'n' to fields array 'f'
	var i;
	
	for( i in f ) {
		if( f[i] == n )
			return false;				// no need to add, already there
	}
	f[f.length] = n;						// add it
	return true;
}


function updateBatchText(oConn, oCmd, u) {
	var lines = u.split("\n");
	var names = lines[0].split(reSplit);
	if( dbg == 1 ) showLine( "names: "+names );
	
	var oRs = Server.CreateObject("ADODB.Recordset");
	oRs.ActiveConnection = oConn;
	oRs.Source = "SELECT * FROM #upload";
	oRs.CursorType = adOpenStatic;
	oRs.LockType = adLockOptimistic;
	oRs.Open();
	
	//------------------------
	for (var i in lines) {
		if( dbg == 1 ) showLine( "lines["+i+"]: "+lines[i] );
		if( i > 0 )
			insertLine(oRs, i, names, lines[i]);
	//------------------------
	}
	oRs.UpdateBatch();
	oRs.Close();
}


function updateBatchFile(oConn, oCmd, u, rad) {

	var names = u[0].split(reSplit);
	
	var oRs = Server.CreateObject("ADODB.Recordset");
	oRs.ActiveConnection = oConn;
	oRs.Source = "SELECT * FROM #upload";
	oRs.CursorType = adOpenStatic;
	oRs.LockType = adLockOptimistic;
	oRs.Open();
	
	//------------------------
	for (var i in u) {
		if( i > 0 ) {
			var v = u[i].split(reSplitList);
			if( v.length >= 2 ) {
				oRs.Addnew();
				oRs("up_id") = i;
				v[0] = v[0].replace(/\s+/g,":");
				v[1] = v[1].replace(/\s+/g,":");
				if( v[0].indexOf(":") >= 0 ) v[0] = hms2deg(v[0]);
				if( v[1].indexOf(":") >= 0 ) v[1] = dms2deg(v[1]);
				for( var j in v )
					oRs("up_"+names[j]).Value = v[j];
				if( v.length == 2 ) {
					oRs("up_sep").Value = rad;
				}
			}
		}
	}
	//------------------------

	oRs.UpdateBatch();
	oRs.Close();
}


function checkRect( raMin, raMax, decMin, decMax ) {
// Check for valid parameters

	var error = false;

	error = error || valueCheck("min_ra",raMin,0,360);
	error = error || valueCheck("raMax",raMax,0,360);
	error = error || rangeCheck("dec",decMin,decMax,-90,90);

	var delta_ra  = raMax-raMin;
	var delta_dec = decMax-decMin;

	error = error || valueCheck("raMax-raMin",delta_ra,0,5.0);
	error = error || valueCheck("decMax-decMin",delta_dec,0,5.0);

	if( error == false)
		return true;
	else
		return false;
}

function UploadCmd(u) {
	var names = u.value.split(reSplit);
	showLine( "names = "+names );
	var cmd = "CREATE TABLE #upload ( up_id int";
	for (i in names) {
		cmd += ", up_" + names[i] + " float";
//		cmd += (names[i] == "ra" || names[i] == "dec" || names[i] == "sep")? "float" : "varchar(32)";
	}
	cmd += " )";
	return cmd;	
}


function readProxText( oCmd, proxText, objType, rad ) {
//	var proxLines = proxText.split( "\n" );
	var proxFields;

	if( dbg == 1 )
		showLine("<pre>");

	var f,l;
	var cmd;


	var names = proxText[0].split( reSplit );
	cmd = "CREATE TABLE #upload ( up_id int";
	for (i in names) {
		cmd += ", up_" + names[i] + " float";
	}
	if( names.length == 2 )
		cmd += ", up_sep float";
	cmd += " ) ";
/*
	for( l in proxLines ) {
		if( l > 0 ) {
			proxFields = proxLines[l].split( reSplit );
			if( proxFields.length > 1 ) {
				cmd += "INSERT #upload VALUES("+l+",";
				cmd += proxFields[0]+","+proxFields[1]+",";
				if( proxFields.length == 2 )
					cmd += rad+"); ";
				else
					cmd += proxFields[2]+"); ";
			}
		}
	}
*/
//	cmd = UploadCmd( proxText );
	sendQuery(oCmd, cmd);
	updateBatchFile( oConn, oCmd, proxText, rad );

	cmd = " ";
	cmd += " CREATE TABLE #x (up_id int,objID bigint) ";
	sendQuery( oCmd, cmd );
	var fun = " dbo.fGetNearestObjIdEq( up_ra,up_dec,up_sep ) ";
	cmd = "INSERT INTO #x SELECT up_id," + fun + "as objId ";
	cmd += "FROM #upload WHERE" + fun + "IS NOT NULL ";
/*
	if( objType.length > 0 ) {
		cmd += " AND (type IN (";
		for( t in objType ) {
			cmd += objType[ t ];
			if( t != objType.length-1 )
				cmd += ",";
		}
		cmd += ")) ";
	}
*/
	if( dbg == 1 )
		showLine( "prox sql cmd = "+cmd+"\n</pre>");
	sendQuery( oCmd, cmd );
	return cmd;
}


function readProxFile( oCmd, proxText, objType, rad ) {
	var f,l;
	var cmd = " ";
	var proxFields;

	if( dbg == 1 )
		showLine("<pre>");

	var names = proxText[0].split(reSplit);
	cmd = "CREATE TABLE #upload ( up_id int";
	for (i in names) {
		cmd += ", up_" + names[i] + " float";
	}
	if( names.length == 2 )
		cmd += ", up_sep float";
	cmd += " ) ";
/*
	for( l in proxLines ) {
		if( l > 0 ) {
			proxFields = proxLines[l].split( reSplit );
			if( proxFields.length > 1 ) {
				cmd += "INSERT #upload VALUES("+l+",";
				cmd += proxFields[0]+","+proxFields[1]+",";
				if( proxFields.length == 2 )
					cmd += rad+"); ";
				else
					cmd += proxFields[2]+"); ";
			}
		}
	}
*/
//	if( dbg == 1 )
//		showLine( "cmd = "+cmd );
//	cmd = UploadCmd( proxText );
	sendQuery(oCmd, cmd);
	updateBatchFile( oConn, oCmd, proxText, rad );

	cmd = " ";
	cmd += " CREATE TABLE #x (up_id int,objID bigint) ";
	sendQuery( oCmd, cmd );
	var fun = " dbo.fGetNearestObjIdEq( up_ra,up_dec,up_sep ) ";
	cmd = "INSERT INTO #x SELECT up_id," + fun + "as objId ";
	cmd += "FROM #upload WHERE" + fun + "IS NOT NULL ";
/*
	if( objType.length > 0 ) {
		cmd += " AND (type IN (";
		for( t in objType ) {
			cmd += objType[ t ];
			if( t != objType.length-1 )
				cmd += ",";
		}
		cmd += ")) ";
	}
*/
	if( dbg == 1 )
		showLine( "prox sql cmd = "+cmd+"\n</pre>");
	sendQuery( oCmd, cmd );
	return cmd;
}


// Read in the imaging (PhotoObj) fields specified by the user and store them in an array
// for stuffing into the SELECT later.

function readImgFields( imgFields, names ) {
	var ignoreImg = true;
//	var names = val.split(reSplit);
	for( var j in names ) {
		if( dbg == 1 )
			showLine( "imgparam name "+j+"="+names[j] );
		if( names[j] != "none" && names[j] != "blankImg" )
			ignoreImg = false;
		else 
			continue;
		switch( names[j] ) {
		case "minimal":
			addField( imgFields, "run" );
			addField( imgFields, "rerun" );
			addField( imgFields, "camCol" );
			addField( imgFields, "field" );
			addField( imgFields, "obj" );
			break;
		case "typical":
			addField( imgFields, "run" );
			addField( imgFields, "rerun" );
			addField( imgFields, "camCol" );
			addField( imgFields, "field" );
			addField( imgFields, "obj" );
			addField( imgFields, "ra" );
			addField( imgFields, "[dec]" );
			addField( imgFields, "camCol" );
			addField( imgFields, "r" );
			break;
		case "radec":
			addField( imgFields, "ra" );
			addField( imgFields, "[dec]" );
			break;
		case "model_mags":
			addField( imgFields, "u" );
			addField( imgFields, "g" );
			addField( imgFields, "r" );
			addField( imgFields, "i" );
			addField( imgFields, "z" );
			break;
		case "model_magerrs":
			addField( imgFields, "modelMagErr_u" );
			addField( imgFields, "modelMagErr_g" );
			addField( imgFields, "modelMagErr_r" );
			addField( imgFields, "modelMagErr_i" );
			addField( imgFields, "modelMagErr_z" );
			break;
		case "psf_mags":
			addField( imgFields, "psfMag_u" );
			addField( imgFields, "psfMag_g" );
			addField( imgFields, "psfMag_r" );
			addField( imgFields, "psfMag_i" );
			addField( imgFields, "psfMag_z" );
			break;
		case "psf_magerrs":
			addField( imgFields, "psfMagErr_u" );
			addField( imgFields, "psfMagErr_g" );
			addField( imgFields, "psfMagErr_r" );
			addField( imgFields, "psfMagErr_i" );
			addField( imgFields, "psfMagErr_z" );
			break;
		case "petro_mags":
			addField( imgFields, "petroMag_u" );
			addField( imgFields, "petroMag_g" );
			addField( imgFields, "petroMag_r" );
			addField( imgFields, "petroMag_i" );
			addField( imgFields, "petroMag_z" );
			break;
		case "petro_magerrs":
			addField( imgFields, "petroMagErr_u" );
			addField( imgFields, "petroMagErr_g" );
			addField( imgFields, "petroMagErr_r" );
			addField( imgFields, "petroMagErr_i" );
			addField( imgFields, "petroMagErr_z" );
			break;
		case "SDSSname":
			addField( imgFields,"SDSSname" );
			break;
		default:
			addField( imgFields, names[j] );
		}
	}
	return ignoreImg;
}


// Read in the spectro (SpecObj) fields specified by the user and store them in an array
// for stuffing into the SELECT later.

function readSpecFields( specFields, names, specQry ) {
	var ignoreSpec = true;
//	var names = val.split(",");
	for( var j in names ) {
		if( dbg == 1 )
			showLine( "specparam name="+names[j] );
		if( names[j] == "none" && names.length == 1)
			ignoreSpec = true;
		else {
			ignoreSpec = false;
			if( (names[j] != "none") ) {
				if( names[j] == "minimal" ) {
					addField( specFields, "plate" );
					addField( specFields, "mjd" );
					addField( specFields, "fiberid" );
				} else if( names[j] == "typical" ) { 
					addField( specFields, "plate" );
					addField( specFields, "mjd" );
					addField( specFields, "fiberid" );
					addField( specFields, "z" );
					addField( specFields, "zErr" );
					addField( specFields, "zWarning" );
					addField( specFields, "specClass" );
				} else if( names[j] == "radec" ) {
					addField( specFields, "ra" );
					addField( specFields, "[dec]" );
				} else {
					if( names[j] != "bestdb" && names[j] != "blankSpec" )
						addField( specFields, names[j] );
				}
			}
		}
	}
	return ignoreSpec;
}


// Set the limits on the magnitudes as entered by the user.

function magLimits( name, val, prefix, magType ) {
	var constraint;
	if( magType.length > 0 && magType != "model" )
		prefix += "."+magType+"Mag_";
	else
		prefix += ".";

	switch( name ) {
	// Now process the individual constraints.
	case "uMin":
		constraint = " "+prefix+"u > "+val;
		break; 
	case "gMin":
		constraint = " "+prefix+"g > "+val;
		break; 
	case "rMin":
		constraint = " "+prefix+"r > "+val;
		break; 
	case "iMin":
		constraint = " "+prefix+"i > "+val;
		break; 
	case "zMin":
		constraint = " "+prefix+"z > "+val;
		break; 
	case "uMax":
		constraint = " "+prefix+"u < "+val;
		break; 
	case "gMax":
		constraint = " "+prefix+"g < "+val;
		break; 
	case "rMax":
		constraint = " "+prefix+"r < "+val;
		break; 
	case "iMax":
		constraint = " "+prefix+"i < "+val;
		break; 
	case "zMax":
		constraint = " "+prefix+"z < "+val;
		break; 
	case "ugMin":
		constraint = " ("+prefix+"u - "+prefix+"g) > "+val;
		break; 
	case "grMin":
		constraint = " ("+prefix+"g - "+prefix+"r) > "+val;	
		break; 
	case "riMin":
		constraint = " ("+prefix+"r - "+prefix+"i) > "+val;
		break; 
	case "izMin":
		constraint = " ("+prefix+"i - "+prefix+"z) > "+val;
		break; 
	case "ugMax":
		constraint = " ("+prefix+"u - "+prefix+"g) < "+val;
		break; 
	case "grMax":
		constraint = " ("+prefix+"g - "+prefix+"r) < "+val;
		break; 
	case "riMax":
		constraint = " ("+prefix+"r - "+prefix+"i) < "+val;
		break; 
	case "izMax":
		constraint = " ("+prefix+"i - "+prefix+"z) < "+val;
		break;
	default:
		break; 
	}
	return constraint;
}


function addImgSelect( imgField, table ) {
	switch( imgField ) {
	case "ra": 
		selectClause += "str("+table+"."+imgField+",13,8) as ra";
		break;
	case "[dec]": 
		selectClause += "str("+table+"."+imgField+",13,8) as dec";
		break;
	case "model_colors":
		selectClause += "str("+table+".u - "+table+".g,11,8) as ugModelColor,";
		selectClause += "str("+table+".g - "+table+".r,11,8) as grModelColor,";
		selectClause += "str("+table+".r - "+table+".i,11,8) as riModelColor,";
		selectClause += "str("+table+".i - "+table+".z,11,8) as izModelColor";
		break;
	case "ugModelColor":
		selectClause += "str("+table+".u - "+table+".g,11,8) as ugModelColor";
		break;
	case "grModelColor":
		selectClause += "str("+table+".g - "+table+".r,11,8) as grModelColor";
		break;
	case "riModelColor":
		selectClause += "str("+table+".r - "+table+".i,11,8) as riModelColor";
		break;
	case "izModelColor":
		selectClause += "str("+table+".i - "+table+".z,11,8) as izModelColor";
		break;
	case "SDSSname":
		selectClause += "dbo.fIAUFromEq("+table+".ra,"+table+".[dec]) as SDSSname";
		break;
	default:
		selectClause += table+"."+imgField;
	}
}


function buildSelect( bestdb, targdb, photoTable, imgFields ) {
	var bestAlias = "p", targAlias="t";
	if( bestdb ) {
		for( var i in imgFields ) {
			addImgSelect( imgFields[i], bestAlias );
			if( i < (imgFields.length - 1) )
				selectClause += ",";
		}
		if( fromClause.length > 5 )
			fromClause += ", ";		
		fromClause += " BEST"+release+".."+photoTable+" as "+bestAlias;
		if( targdb ) {
			selectClause += ","
			for( i in imgFields ) {
				addImgSelect( imgFields[i], targAlias );
				if( i < (imgFields.length - 1) )
					selectClause += ",";
			}
			fromClause += ", TARG"+release+".."+photoTable+" as "+targAlias;
		}
	} else {
		if( targdb ) {
			for( i in imgFields ) {
				addImgSelect( imgFields[i], bestAlias );
				if( i < (imgFields.length - 1) )
					selectClause += ",";
			}
		}
		if( fromClause.length > 5 )
			fromClause += ", ";		
		fromClause += " TARG"+release+".."+photoTable+" as "+bestAlias;
	}
}


function buildQuery(oCmd, f, type) {

	var name, options, filters="";
	var imgFields = new Array(), specFields = new Array();
        var objType = new Array(), magCut = new Array(), colorCut = new Array();
	var i, j, k=0, l=0, t=0;
	var ignoreImg = false, ignoreSpec = false;
	var posType = " ";
	var bestdb = true, targdb = false;
	var val;
	var flagsOn="", flagsOff="",priFlagsOn="",priFlagsOff="",secFlagsOn="",secFlagsOff="";
	var bestAlias = "p";
	var targAlias = "t";
	var tableAlias = bestAlias;
	var photoTable = "PhotoObj";
	var specTypes = "", magType = "model";
	var cmd = "", orderClause="";
	var doStar = false, doGalaxy = false, doSky = false, doUnknown = false;
	var proxCmd = " ", proxList, proxMode = " ", proxRad = 0.;

	// Read the form input.
	for( i in f ) {
		val = f[i].value;
		if( val.length == 0 )
			continue;
		options = f[i].body;
		name = f[i].name;
		switch( name ) {
		case "limit":
			if( val > 0 )
				selectClause += "TOP "+val+" ";
			break;
		case "imgparams":
			ignoreImg = readImgFields( imgFields, options );
			break;
/*
		case "bestdb":
			if( val == "on" )
				bestdb = true;
			break;
		case "targdb":
			if( val == "on" )
				targdb = true;
			break;
*/
		case "dataset":
			if( val == "targdb" ) {
				targdb = true;
				bestdb = false;
			}
			break;
		case "specparams":
			ignoreSpec = readSpecFields( specFields, options );
			break;
		case "uFilter":
			filters += "u";
			break;
		case "gFilter":
			filters += "g";
			break;
		case "rFilter":
			filters += "r";
			break;
		case "iFilter":
			filters += "i";
			break;
		case "zFilter":
			filters += "z";
			break;
		case "positionType":
			posType = val;
			break;				
		case "imagingConstraint":
			if( val == "target" )
				tableAlias = targAlias;
			else
				tableAlias = bestAlias;
			break;
		case "magType":
			magType = val;
			break;

		case "raMin":
			if( posType == "rectangular" ) {
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = hms2deg(val);
				raMin = val;
			}
			break;
		case "raMax":
			if( posType == "rectangular" ) {
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = hms2deg(val);
				raMax = val;
			}
			break;
		case "decMin":
			if( posType == "rectangular" ) {
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = dms2deg(val);
				decMin = val;	
			}
			break;
		case "decMax":
			if( posType == "rectangular" ) {
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = dms2deg(val);
				decMax = val;
			}
			break;
		case "raCenter":
			if( posType == "cone" ) {
				if( fromClause.length > 5 )
					fromClause += ", ";
				if( targdb )
					fromClause += " TARG"+release+".";		
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = hms2deg(val);
				fromClause += "dbo.fGetNearbyObjEq("+val+",";
			}
			break;
		case "decCenter":
			if( posType == "cone" ) {
				val = val.replace(/\s+/g,":");
				if( val.indexOf(":") >= 0 ) val = dms2deg(val);
				fromClause += val+",";
			}
			break;
		case "radius":
			if( posType == "cone" ) {
				fromClause += val+") as b";
				whereClause += "b.objID = p.objID";
			}
			break;
		case "radecTextarea":
			if( posType == "proximity" ) {
				var paste = val.split( reSplit );
				if( paste.length > 0 ) {
					proxList = f[i].body;
					proxMode = "text";
				}
			}	
			break;
		case "radecFilename":
			if( posType == "proximity" ) {
				if( f[i].body.length > 0 ) {
/*
					if (f[i].type != "text/plain") {
						cmd = "ERROR: Proximity upload file not a text file but "+ f[i].type;
						return cmd;
					}
*/
					// it is a text file, we process it.
					proxList = f[i].body;
					proxMode = "file";
				}
			}
			break;
		case "radiusDefaultArcsec":
			if( posType == "proximity" ) {
				proxRad = val;
			}
			break;
		case "uMin":
		case "gMin":
		case "rMin":
		case "iMin":
		case "zMin":
		case "uMax":
		case "gMax":
		case "rMax":
		case "iMax":
		case "zMax":
		case "ugMin":
		case "grMin":
		case "riMin":
		case "izMin":
		case "ugMax":
		case "grMax":
		case "riMax":
		case "izMax":
		case "raMin":
		case "raMax":
		case "decMin":
		case "decMax":
			// For all the constraints, first check if this is first constraint in WHERE;
			// if not, prepend an AND.
			if( val.length == 0 )
				break;
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += magLimits( f[i].name, val, tableAlias, magType ); 
			break;
		case "doGalaxy":
			if( val == "on" ) {
				doGalaxy = true;
				objType[t++] = "3";
			}
			break;
		case "doStar":
			if( val == "on" ) {
				doStar = true;
				objType[t++] = "6";
			}
			break;
		case "doSky":
			if( val == "on" ) {
				doSky = true;
				objType[t++] = "8";
			}
			break;
		case "doUnknown":
			if( val == "on" ) {
				doUnknown = true;
				objType[t++] = "0";
			}
			break;
		case "redshiftMin":
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " s.z > "+val;
			break;
		case "redshiftMax":
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " s.z < "+val;
			break;
		case "zConfMin":
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " s.zConf > "+val;
			break;
		case "zConfMax":
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " s.zConf < "+val;
			break;
		case "specClass":
			for (j in options ) {
				if( options[j] == "ALL" ) {
					specTypes = "";
					break;
				} else {
					if( specTypes.length > 0 )
						specTypes += " OR ";
					specTypes += "s.specClass = dbo.fSpecClass('"+options[j]+"')";
				}
			}
			if( specTypes.length > 0 ) {
				if( whereClause.length > 6 )
					whereClause += " AND";
				whereClause += " ("+specTypes+")";
			}	
			break;			
		case "flagsOnList":
			for (j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						flagsOn += " + ";
					flagsOn += "dbo.fPhotoFlags('"+options[j]+"')";
				}
			}
			break;
		case "flagsOffList":
			for( j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						flagsOff += " + ";
					flagsOff += "dbo.fPhotoFlags('"+options[j]+"')";
				}
			}				 
			break;
		case "priFlagsOnList":
			for (j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						priFlagsOn += " + ";
					priFlagsOn += "dbo.fPrimTarget('"+options[j]+"')";
				}
			}
			break;
		case "priFlagsOffList":
			for( j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						priFlagsOff += " + ";
					priFlagsOff += "dbo.fPrimTarget('"+options[j]+"')";
				}
			}				 
			break;
		case "secFlagsOnList":
			for (j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						secFlagsOn += " + ";
					secFlagsOn += "dbo.fSecTarget('"+options[j]+"')";
				}
			}
			break;
		case "secFlagsOffList":
			for( j in options ) {
				if( options[j] != "ignore" ) {
					if( j > 0 )
						secFlagsOff += " + ";
					secFlagsOff += "dbo.fSecTarget('"+options[j]+"')";
				}
			}				 
			break;
		default:
//			showLine( "name="+f[i].name );
			break;
		}
	}
	if( doStar & !doGalaxy && !doSky && !doUnknown ) {
		photoTable = "Star";
	} else if( doGalaxy && !doStar && !doSky && !doUnknown ) {
		photoTable = "Galaxy";
	} else if( doSky && !doGalaxy && !doStar && !doUnknown ) {
		photoTable = "Sky";
	} else if( doUnknown && !doGalaxy && !doStar && !doSky ) {
		photoTable = "Unknown";
	} else {
		photoTable = "PhotoObj";
		if( objType.length > 0 ) {
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " (";
			for( t in objType ) {
				whereClause += " "+tableAlias+".type = "+objType[t];
				if( t < objType.length-1 )
					whereClause += " OR";
			}
			whereClause += ")";
		}
	}
	if( flagsOff.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".flags & ("+flagsOff+") = 0)";
	}
	if( flagsOn.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".flags & ("+flagsOn+") > 0)";
	}
	if( priFlagsOff.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".primTarget & ("+priFlagsOff+") = 0)";
	}
	if( priFlagsOn.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".primTarget & ("+priFlagsOn+") > 0)";
	}
	if( secFlagsOff.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".secTarget & ("+secFlagsOff+") = 0)";
	}
	if( secFlagsOn.length > 0 ) {
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " ("+tableAlias+".secTarget & ("+secFlagsOn+") > 0)";
	}

	// Put the pieces of the query together.

	if( posType == "rectangular" ) {
		if( !checkRect(raMin, raMax, decMin, decMax) ) {
			if( dbg == 1 )
				showLine( "Illegal rectangular search values: "+raMin+","+raMax+","+
						decMin+","+decMax+"." );
			cmd = "ERROR: Illegal rectangular search values: "+raMin+","+raMax+","+
						decMin+","+decMax+".";
			return cmd; 
		} else {
			if( fromClause.length > 5 )
				fromClause += ", ";		
			if( targdb )
				fromClause += " TARG"+release+".";		
			fromClause += "dbo.fGetObjFromRect("+raMin+","+raMax+","+decMin+","+decMax+") b";
			if( whereClause.length > 6 )
				whereClause += " AND";
			whereClause += " "+tableAlias+".objID=b.objID";
		}
	}

	if( posType == "proximity" ) {
		if( proxMode == "text" )
			proxCmd = readProxText( oCmd, proxList, objType, proxRad );
		else if( proxMode == "file" )
			proxCmd = readProxFile( oCmd, proxList, objType, proxRad );
		else {
			cmd = "ERROR: Neither upload file nor list specified for Proximity search.\n";
			return cmd;
		}
		selectClause += "p.ra,p.dec,";
		if( fromClause.length > 5 )
			fromClause += ", ";		
		fromClause += " #x x, #upload u";
		if( whereClause.length > 6 )
			whereClause += " AND";
		whereClause += " u.up_id = x.up_id AND x.objID=p.objID";
		orderClause += "ORDER BY x.up_id"
	}
	if( type == "spec" ) {
		if( specFields.length == 0 ) {
			var specOpts = new Array();
			specOpts[0] = "minimal";
			readSpecFields( specFields, specOpts );
		}
		for( i in specFields ) {
			if( specFields[i] == "ra" ) { 
				selectClause += "str(s."+specFields[i]+",13,8) as ra";
			} else if( specFields[i] == "[dec]" ) {
				selectClause += "str(s."+specFields[i]+",13,8) as dec";
			} else {
				selectClause += "s."+specFields[i];
			}
			if( i < specFields.length-1 )
				selectClause += ",";
		}
		if( whereClause.length > 6 )
			whereClause += " AND";
		if( targdb )
			whereClause += " s.targetObjID = p.objID";
		else
			whereClause += " s.bestObjID = p.objID";
		if( !ignoreImg )
			selectClause += ",";
		buildSelect( bestdb, targdb, photoTable, imgFields );
	} else {
		buildSelect( bestdb, targdb, photoTable, imgFields );
		if( !ignoreSpec ) {
			fromClause += " LEFT OUTER JOIN BEST"+release+"..SpecObj s ON p.objID = s.bestObjID";
			for( i in specFields ) {
				if( specFields[i] == "ra" ) { 
					selectClause += ",ISNULL(str(s."+specFields[i]+",13,8),0) as ra";
				} else if( specFields[i] == "[dec]" ) {
					selectClause += ",ISNULL(str(s."+specFields[i]+",13,8),0) as dec";
				} else {
					selectClause += ",ISNULL(s."+specFields[ i ]+",0) as "+specFields[i];
				}
			}
		}
	}
	if( filters.length > 0 )
		selectClause += ", '"+filters+"' as filter";
	cmd += selectClause+"\n"+fromClause+"\n"+whereClause+"\n"+orderClause;
	if( dbg == 1 )
		showLine( "buildQuery, cmd = <pre>"+cmd+"</pre>\n" );	
	return cmd;
}


function sendQuery(oCmd,cmd) {
	if (dbg==1) showLine(cmd) ;
	
	oCmd.CommandTimeout = defTimeout;
	oCmd.CommandText = cmd;
	var oRs = oCmd.Execute();
}


function getNearest(oCmd, radius, qclass, qselect) {

	if (dbg==1) showLine("<h4>Get nearest primary object within "+radius+" arcmins</h4>");

	sendQuery(oCmd,"create table #x (up_id int,objID bigint)");

	var fun = " dbo.fGetNearestObjIdEq";
	if (qclass=="") fun += "(up_ra,up_dec,"+radius+") ";
	else fun += "Type(up_ra,up_dec,"+radius+","+qclass+") ";
	var cmd = "INSERT INTO #x SELECT up_id," + fun + "as objId \n     ";
	cmd	   += "FROM #upload WHERE" + fun + "IS NOT NULL";
	sendQuery(oCmd, cmd);

	if (qselect.value == "c") {
	    showTable(oCmd,"select count(*) as count from #x x, #upload u, photoPrimary p where u.up_id = x.up_id and x.objID=p.objID"+qclass);
	} else {
		var cmd  = getSelect(f.qselect.value);
		cmd += " from #x x, #upload u, photoPrimary p ";
		cmd += " where u.up_id = x.up_id and x.objID=p.objID order by x.up_id"
		showTable(oCmd,cmd);
	}

}


function getNearby(oCmd,f) {

	var radius = f.radius.value;
	var qclass  = "";
	if (f.qclass.value== "g") qclass = " and p.type=3";
	if (f.qclass.value== "s") qclass = " and p.type=6";

	if (dbg==1) showLine("<h4>Get all nearby primary objects of type "+f.qclass.value+" within "+radius+" arcmins</h4>");

	sendQuery(oCmd,"create table #x (up_id int,objID bigint)");
	sendQuery(oCmd,"insert into #x EXEC dbo.spGetNeighbors "+radius);

	if (f.qselect.value == "c") {
	    showTable(oCmd,"select count(*) as count from #x x, #upload u, photoPrimary p where u.up_id = x.up_id and x.objID=p.objID"+qclass);
	} else {
		var cmd  = getSelect(f.qselect.value);
		cmd += " from #x x, #upload u, photoPrimary p";
		cmd += " where u.up_id = x.up_id and x.objID=p.objID";
		cmd += qclass;
		cmd += " order by x.up_id";
		showTable(oCmd,cmd);
	}
}

function getSelect(qselect) {
	
	var attr = "select u.*";
	if (qselect == "c")
		return attr;
	
	if (qselect == "l") 
		return attr+", p.*";

	if (f.format.value=="html")
		attr += ", '<a target=INFO href='+dbo.fGetUrlExpId(p.objId)+'>'+ cast(p.objId as varchar(20)) + '</a>' as url";
	else if (f.format.value=="csv")
		attr += ", p.objID, dbo.fGetUrlExpId(p.objId) as url";
	else
		attr += ", p.objId";
	if (qselect == "u") 
		return attr;

	attr += ", str(p.ra,9,5) as ra, str(p.dec,9,5) as dec, dbo.fPhotoTypeN(p.type) as type";
	if (qselect == "t")
		return attr;

	attr += ", p.status, str(p.u,6,2) as u, str(p.g,6,2) as g";
	attr += ", str(p.r,6,2) as r, str(p.i,6,2) as i, str(p.z,6,2) as z";
	if (qselect == "s")
		return attr;

	attr += ", str(p.Err_u,5,2) as Err_u, str(p.Err_g,5,2) as Err_g, str(p.Err_r,5,2) as Err_r";
	attr += ", str(p.Err_i,5,2) as Err_i, str(p.Err_z,5,2) as Err_z, p.specObjId";
	return attr;
}


function showCount(oCmd,cmd) {
    oCmd.CommandText = cmd;
	var oRs = oCmd.Execute();
	if (!oRs.eof)
		Response.Write("<h3>"+oRs.fields(0).value+" objects found</h3>\n");
	oRs.close();
}


function UploadCmd(u) {
	var names = u.value.split(reSplit);
	var cmd = "CREATE TABLE #upload ( up_id int";
	for (i in names) {
		cmd += ", up_" + names[i] + " ";
		cmd += (names[i] == "ra" || names[i] == "dec")? "float" : "varchar(32)";
	}
	cmd += " )";
	return cmd;	
}


//---------------------------------
// create Form class
//---------------------------------

function Form(n) {
	this.name  = n;
	this.type  = "";
	this.value = "";
	this.values = new Array();
	this.body  = new Array();
}

Form.prototype.Add = function(s) {
	var n = this.body.length;
	this.body[n] = s;
	if (n==0) this.value = this.body[n];
//	showLine( "<pre>" );
//	showLine("form name="+this.name+", add "+s+" as body["+n+"]\n");
//	showLine( "</pre>" );
}

function getName(s) {
		var n = s.indexOf("name=");
		return s.substring(n+6,s.indexOf("\"",n+7));
}

function getType(s) {
		var n = s.indexOf("Type:");
		return s.slice(n+6);
}


function formExists(f,n) {
	for( var i in f )
		if( f[i].name == n )
			return true;
	return false;
}


function showLine(s) {
		Response.Write(s+"\n");
}

function showForms(f) {
	showLine("<pre>");
	for (var i in f) {
               	showLine("["+f[i].name+"] {" + f[i].value + "} [" + f[i].type +"]");
		if (f[i].body.length>0)
			for (j in f[i].body)
				showLine("|"+j+"|"+f[i].body[j]+"|");
	}
    showLine("</pre>");
}

//-----------------------------------
// read the input data
//-----------------------------------

function getQueryString() {
//----------------------------------
// Extract the parameters from the QueryString.
// Add name, type, value and body
//----------------------------------
	if(dbg==1){
		showLine("<pre>");
		showLine(Request.QueryString);
		showLine("</pre>");
	}
	
	var f = new Array;
	var a = ["limit","format","imgparams", 
//               "bestdb", "targdb", 
		 "dataset",
		 "specparams",
		 "uFilter","gFilter","rFilter","iFilter","zFilter",
		 "positionType",
		 "raMin","raMax","decMin","decMax",
		 "raCenter","decCenter","radius",
		 "radecTextarea","radecFilename","radiusDefaultArcsec",
		 "imagingConstraint",
		 "magType","uMin","gMin","rMin","iMin","zMin","uMax","gMax","rMax","iMax","zMax",
		 "redshiftMin","redshiftMax","zConfMin","zConfMax",
		 "priFlagsOnList","priFlagsOffList","secFlagsOnList","secFlagsOffList",
                 "color","ugMin","grMin","riMin","izMin","ugMax","grMax","riMax","izMax",
		 "objectType","doGalaxy","doStar","doSky","doUnknown","flagsOnList","flagsOffList"];

	var buffer = "";	
	var key = new String();
	for(var i=0; i<Request.QueryString.Count;i++) {
		key = Request.QueryString.Key(i+1);
		for (var n=0;n<a.length;n++) {
			if (key == a[n]) {
				f[key] = new Form(key);
				f[key].value = String(Request.QueryString(key));
				if(dbg==1)
					showLine("key="+f[key].name+", value="+f[key].value);
			}			
		}		
	}
	
	
	return f;	
}


function checkForms(f) {
//----------------------------------
// checks if the values of the forms
// containing the parameters are valid
// returns null otherwise.
//----------------------------------
	
	if ( !f.search.value.match(/(a|n)/) )
		return Error(" illegal value, [search]="+f.search.value);

	if ( !f.qclass.value.match(/(a|g|s)/) )
		return Error(" illegal value, [qclass]="+f.qclass.value);

	if ( !f.qselect.value.match(/(c|u|t|s|m|l)/) )
		return Error(" illegal value, [qselect]="+f.qselect.value);

	if ( !f.format.value.match(/(html|csv|xml)/) )
		return Error(" illegal value, [format]="+f.format.value);

	if ( !f.radius.value.match(reSignedFloat) )
		return Error(" illegal value, [radius]="+f.radius.value);

	return 1;
}

function getForms() {
//----------------------------------
// Extract the forms from the Request.Forms buffer
// Add name, type, value and body
//----------------------------------
	var buf		= String(makeStrB(Request.BinaryRead(Request.TotalBytes)));
	var lines	= buf.split(/\r*\n/);
	var b		= lines[0];
	var f		= new Array();
	var s,name;
	
	for	(var i=0;i<lines.length; i++) {
		s = String(lines[i]);
		if (s.indexOf(b)!=-1 ) {		// multiform boundary marker
			// just skip it
		} else if (s.indexOf("Content-Disposition:")!=-1) {
			name = getName(s);
			if( !formExists(f, name) ) {
				f[name] = new Form(name);
			}
		} else if (s.indexOf("Content-Type:")!=-1) {
			f[name].type = getType(s);
		} else if (s.replace(reBlank,"") != "") {
			f[name].Add(s);
		}
	}
	return f;
}

function getUploadFormat(u) {
//----------------------------------
// Figure out what is the format of the file
// u.value has the first line of the upload
// upon return, the type has the format designator
//----------------------------------
	var s = u.value;
	u.value = "";
	
	if (dbg==1) {
		showLine("<pre>");
		showLine("starting getUploadFormat");
		showLine("|"+s+"|");
		showLine("</pre>");
	}
	
	// check for Gator format
		if ( s.match(/^\\\ \w+/) ) {
			// need to scroll forward to the beginning of data
			while ( u.body[0].match(/^\\/) ) u.body.splice(0,1);
			if ( u.body[0].match(/^\s*\|/) && u.value == "" ) {
				u.value = String(u.body[0]).replace(/\|/g," ");
				u.body.splice(0,2);
			}
			u.type = "G";
			return "G";		
		}

	// is it a comma/whitespace?
		var c = s.split(reSplit);
		var n = c.length;
		if (n<2 || n>3) 
			return Error(n+ " items in first line: '"+s+"'");
	
	// we have 2 or 3 values, are they numbers or text
		if ( c[n-1].match(reSignedFloat) !=null ) {
			u.value = (n==2)? "ra dec": "name ra  dec";
			u.type = "N"+n;
			return "N"+n;		
		}
		if ( c[n-2].match(/^ra$/i)!=null 
			&& c[n-1].match(/^dec$/i)!=null) {
			for (i in c)
				u.value += " "+c[i];
			u.body.splice(0,1);
			u.type = "H"+n;
			return "H"+n;
		}
	return Error("Error in header line \" "+s+"\"");;
}


function getQueryForms() {

	// check that total upload size < 100KB	

	if (Request.TotalBytes>100000)
		return Error("upload is larger than 100KB!");

	// size is ok, process the upload

	var f = getForms();	

	// check whether at least one of the two sources is set

	if (f.upload.body.length==0 && f.paste.body.length==0)
		return Error("need either paste or upload!");

	// if there is a file, it takes precedence. Is it the correct type?	

	if (f.upload.body.length>0) {
/*
		if (f.upload.type != "text/plain") 
			return Error("upload not a text file but "+ f.upload.type);
*/
		// it is a text file, we process it.
		upload = f.upload.body;

	} else {				

		// there is no file, but there is paste 
		f.upload.body  = f.paste.body;
		f.upload.value = f.paste.value;
		f.upload.type  = "";

	}

	delete f.paste;	
	return f;		
}




function Error(msg) {
	Response.Write("<h2><font color=red>Error:</font> "+msg+"</h2>\n");
	return null;
}

//------------------------------------
%>
