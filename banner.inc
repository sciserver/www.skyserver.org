<!----------------<include from banner.inc>------------->
<%
	var banner,imgpath;
	imgpath = "../img/";

	if (gselect==0) {								// pagelevel=1
		imgpath = "../img/";
		banner = "banner.gif";
	} else if (gselect==Math.floor(gselect) ) {			// pagelevel=2
		imgpath = "../../img";
		banner  = imgpath+"/sdss-skyserver.gif";
	}
	if (depth==2) {								// pagelevel=2.x
		imgpath = "../../img";
		banner  = imgpath+"/sdss-skyserver.gif";
	} else if  (depth==3) {
		imgpath = "../../../img";
		banner  = imgpath+"/sdss-skyserver.gif";
    } else if (depth==4) {
		imgpath = "../../../../img";
		banner  = imgpath+"/sdss-skyserver.gif";
    }
%>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0"  bottommargin="0">
<!------------#include file="navimap.inc"------------->
<!------------#include file="../makegutter.js"------------->
<!---------------------<end of include>----------------->
