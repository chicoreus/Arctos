<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html>
<head>
		
	<title></title>
</head>			
<body>
	
	<div class="content">
	
</div>

<style>
	
	.annotateBox {
	border:3px solid green;
	z-index:9999;
	position:absolute;
	top:5%;
	left:5%;
	width:85%;
	height:85%;
	background-color:white;
	overflow:auto;
}
.imgDiv{
	float: left;
	margin:.1em;
	max-width:200px;
	max-height:200px;
}
.imgCaption{
	text-align:center;
	margin:.0em;
	font-style: italic;
	font-size: smaller;
  	text-indent: 0;
}
.imgStyle{
	max-width:200px;
	max-height:200px;
}
.greenBorder {
	border:1px solid green;
}
.redBorder {
	border:1px solid red;
}
.blackBorder {
	border:1px solid black;
}
.cellDiv {
	border:1px dashed green;
	padding:10px;
	margin: 10px;
	width:80%;
}
label.badPickLbl {
	color:red;
	width:15em;
	height:2em;
	background-image:url('/images/caution.gif');
	background-repeat:no-repeat;
	background-position:right; 
	display: table-cell; 
	vertical-align: bottom;
}
.noShow {
	display:none;
}
.doShow {
	display:block;
}
.browserCheck {
	text-align:center;
	border:1px dotted #CC0000;
	font-size:smaller;	
}
.goodPW {
	font-size:smaller;
	background-color:green;
	margin-left:.1em;
	padding:.2em;
}
.badPW {
	font-size:smaller;
	background-color:red;
	margin-left:.1em;
	padding:.2em;
}
.showType {
	font-size:small;
	color:green;
	border:1px dotted green;
	padding-left:5px;
}
.pickBox {
	border:2px solid green;	
	z-index:2001;
	background-color:gray;
	position:absolute;
	width:50%;
	top:20%;
	padding: 12px;
	left:20%;
}
.bgDiv {
	background:#024;
	height:300%;
	width:120%;
	position:absolute;
	top:0;
	left:0;
	opacity:0.2;
	z-index:2000;
}
.mediaLink {
	padding-left:5px;	
	color:#2B547E;
	font-size:small;
	font-family:Arial, Helvetica, sans-serif;
	display:block;
}
.mediaLink:hover {
	color:#FF0000;
	text-decoration: underline;
}
.mediaLink:visited {
	color:#2B547E;
}
.ajaxStatus{
	background-color:yellow;
	position:absolute;top:5em;right:0%;
	font-size:small;
	padding:5px;
}
.hdrCredit {
	font-size:small;
}
/************************************** jquery suggest plugin ************************/
.ac_results {
	padding: 0px;
	border: 1px solid black;
	background-color: white;
	overflow: hidden;
	z-index: 99999;
}
.ac_results ul {
	width: 100%;
	list-style-position: outside;
	list-style: none;
	padding: 0;
	margin: 0;
}
.ac_results li {
	margin: 0px;
	padding: 2px 5px;
	cursor: default;
	display: block;
	font: menu;
	font-size: 12px;
	line-height: 16px;
	overflow: hidden;
}
.ac_loading {
	background: white url('/images/indicator.gif') right center no-repeat;
}
.ac_odd {
	background-color: #eee;
}
.ac_over {
	background-color: #0A246A;
	color: white;
}
.smallBtn {
	color:	#666666;
	font-size:.9em;
	font-weight:bold;
	background-color:#99CCFF;
	border:1px solid #336666;;
}
.smallBtn:hover {
	color:	red;
	cursor:pointer;
}
.loginTxt {
	font-size:.7em;
}
.helpLink {
	cursor:pointer;
	color: blue;
	text-align:right;
}
.helpLink:hover {
	color: #CC0000;
	text-decoration:underline;
}
.docSrchTip {
	font-size:smaller;
	padding-left:5px;
	padding-top:5px;
}	
.docDef {
	font-size:smaller;
	padding-left:5px;
}	
.docMoreInfo{font-size:smaller;}
.docControl {
	position:absolute;
	top:0px;
	right:0px;
	border:1px solid red;
	background-color:gray;
	z-index:101;
	cursor:pointer;
	padding:1px;
	font-size:.7em;
	}
.docTitle {
	font-weight:bold;
	padding-right:20px;
	font-size:smaller;
	}
.helpBox {
	border:1px solid green;
	padding:5px;
	background-color:#99C68E;
	max-width:20em;
	padding:.1em;
}
.sscustomBox {
	border:3px solid green;
	padding:.5em;
	z-index:9999;
	position:absolute;
	top:5%;
	left:5%;
	background-color:white;
	max-width:60em;
}
.secHead{background-color:lightgrey;}
.secLabel{
	float:left;
	font-weight:bold;
}
.secControl ,.infoLink a:visited{
	float:right;
	padding-right:1em;
	cursor:pointer;
	color:#2B547E;
	font-size:.65em;
	font-family:Arial, Helvetica, sans-serif;
}
.secControl:hover {
	color:#FF0000;
	text-decoration: underline;
	}
.secDiv {
	border:1px solid green;
	width:50em;
	margin-left:1em;
}
table.ssrch {
	width:100%;
}
td.lbl {
	width:15em;
	text-align:right;
	padding-right:5px;
}
.detailBlock{
}
.innerDetailLabel{
	color: #000000;
	font-weight:normal;
}
.detailData{
	margin-left:-10px;
}
.detailCellSmall {
	font-size:.6em;
	font-weight:normal;
	color: #444444;
}
.detailCell {
	border:1px dotted gray;
	text-align:left;
	padding:2px 3px 3px 15px;
	position:relative;
	margin:1px 6px 12px 2px;
	}
.detailLabel {
	margin: 1px 0px 1px -11px;
	position:relative;
	color: #6a6a6a;
	font-size:1em;
	}
.detailEditCell {
	float:right;
	right:2px;
	top:0px;;
	position: absolute;
	cursor:pointer;
	color:#2B547E;
	font-size:.6em;
	font-family:Arial, Helvetica, sans-serif;
	}
.detailEditCell:hover {
	color:#FF0000;
	text-decoration: underline;
	}
table#SD {
	border-collapse: collapse;
}
td#SDCellLeft{
	text-align: right;
	row-span: 1;
	}
td#SDCellRight{
	text-align: left;
	row-span: 1;
	}
.detailElements{
	font-size:1em;
}
.headerInstitutionText {
	font-family:Arial, Helvetica, sans-serif;
	color:#000066; 
	font-weight:bold;
}
.headerCollectionText {
	font-family:Arial, Helvetica, sans-serif;
	font-size:24px;
	color:#000066;
}
.annotateSpace, .annotateSpace a:visited .annotateSpace a {
	font-size:.75em;
	font-weight:bold;
	color:#2B547E;
	float:right;
	cursor:pointer;
	font-family:Arial, Helvetica, sans-serif;}
}
.annotateSpace:hover {
	color:#FF0000;
	text-decoration: underline;
	}
.specResultPartCell {
	font-size: small;
	border:none;	
}
.popDivControl {
	position:absolute;
	top:0px;
	right:0px;
	cursor:pointer;
	color:#2B547E;
	font-size:.85em;
	padding:3px;
	border:1px solid red;
}
.windowCloser {
	float:right;
	clear:left;
	position:relative;
	top:0px;
	cursor:pointer;
	color:#2B547E;
	font-size:.85em;
}
.windowCloser:hover {
	color:#FF0000;
	text-decoration: underline;
}
.uploadMediaDiv {
	border:3px solid red;
	z-index:9999;
	position:absolute;
	top:5%;
	left:5%;
	width:85%;
	height:65%;
	background-color:white;
}
.customBox {
	border:3px solid green;
	z-index:9999;
	position:absolute;
	top:5%;
	left:5%;
	width:65%;
	height:450px;
	background-color:white;
	overflow:auto;
}
.pickDiv {
	border:3px solid green;
	z-index:9999;
	position:absolute;
	top:5%;
	left:5%;
	width:65%;
	height:450px;
	background-color:white;
	overflow:auto;
}
.popDiv {
	border:3px solid green;
	z-index:9999;
	position:absolute;
	background-color:white;
	overflow:auto;
}
table.specResultTab {
	border-width: 1px 1px 1px 1px;
	border-spacing: 0px;
	border-style: outset outset outset outset;
	border-color: gray gray gray gray;
	border-collapse: collapse;
	background-color: white;
}
table.specResultTab th {
	border-width: 1px 1px 1px 1px;
	padding: 0px 1px 0px 1px;
	border-style: solid solid solid solid;
	border-color: gray gray gray gray;
	background-color: white;
	-moz-border-radius: 0px 0px 0px 0px;
	color:gray;
}
table.specResultTab td {
	border-width: 1px 1px 1px 1px;
	padding: 0px 1px 0px 1px;
	border-style: solid solid solid solid;
	border-color: gray gray gray gray;
	background-color: white;
	-moz-border-radius: 0px 0px 0px 0px;
}
.wrapLong {
	font-size:smaller;
	width:250px;
}
div.code {
	font-size:smaller;
	color:#2F4F4F;
}
span.helpDiv{
    position:relative; /*this is the key*/
    z-index:2001;
    color:#0000FF;
    text-decoration:none;}
.red {background-color:#FF0000;}
redCheck{
	border: 5px solid red;}
.infoLink ,.infoLink a:visited {
	cursor:pointer;
	color:#2B547E;
	font-size:.65em;
	font-family:Arial, Helvetica, sans-serif;}
.infoLink:hover {
	color:#FF0000;
	text-decoration: underline;
	}
.browseLink {
	cursor:pointer;
	color: blue;}
.browseLink:hover {
	text-decoration: underline;
	color: #CC0000;
	}
.pageHelp, .pagehelp a:visited{
	font-size:.75em;
	font-weight:bold;
	color:#2B547E;
	float:right;
	}
.error {
	position:absolute;
	font-size:1.2em;
	color:red;
	border:2px solid red;
	padding:.5em;
	margin:10px;
	text-align:center;
	top:50%;
	left:20%;
	background-color:white;
	z-index:20;}
.status {
	position:absolute;
	top:50%;
	right:50%;
	z-index:998;
	background-color:green;
	color:white;
	font-size:large;
	font-weight:bold;
	padding:15px;
}
#navbar {
	color: green;
	border-bottom: 2px solid black;
	border-top: 2px solid black;
	margin: 12px 0px 0px 0px;
	padding: 0px;
	z-index: 1;
	text-align:center;}
#navbar li {
	display: inline;
	overflow: hidden;
	list-style-type: none;}
#navbar a, a.active {
	color: green;
	background-color:#E7E7E7;
	border-right:1px solid black;
	text-decoration: none;
	border-left:1px solid black;
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding: 0px 5px 0px 5px;
	margin: 0px;
	font-weight:bolder;
	font-size:small;
	font-family:Arial, Helvetica, sans-serif;}	
#navbar span, span.active {
	color: green;
	background-color:#E7E7E7;
	border-right:1px solid black;
	text-decoration: none;
	border-left:1px solid black;
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding: 0px 5px 0px 5px;
	margin: 0px;
	font-weight:bolder;
	font-size:small;
	font-family:Arial, Helvetica, sans-serif;}
#navbar a.active {
	background-color:#000000;
	color:green; }
#navbar span.active {
	background-color:#000000;
	color:green; }
#navbar a:hover {
	color:red;
	background: #E7E7E7;
	border-bottom:1px solid black;}
#navbar span:hover {
	color:red;
	background: #E7E7E7;
	border-bottom:1px solid black;}
#navbar a:visited {
	color: #0000FF; }
#navbar span:visited {
	color: #0000FF; }
#navbar a.active:hover {
	background: #FFFFFF;
	color: #FF0000; }
#navbar span.active:hover {
	background: #FFFFFF;
	color: #FF0000; }
div.fldDef {
	float:right; 
	clear:both; 
	border:1px solid green;
	font-size:x-small;
	color:#999999;
	padding:3px;
	margin-left:5px;
	margin-right:2px;
	width:200px;
	z-index:1;}
a.info{
    position:relative; /*this is the key*/
    z-index:24;
    color:#000;
    text-decoration:none;}
a.info:hover{z-index:20;
	background-color: transparent;
	font-size:small;}
a.info span{display: none}
a.info:hover span{ /*the span will display just on :hover state*/
    display:block;
    position:absolute;
    top:2em; left:2em;
    border:1px solid #0cf;
	background-color:#FFFFFF;
    color:#000;
    text-align: center;
	text-decoration:none;}
span.helpLink {
	background-color:#FFFFFF; 
	padding:2px;}
h1 {
	font-size:2em;
	font-weight: bold;}
h2 {
	font-size:1.6em;
	font-weight:bold;}
table.sortable a.sortheader {
    background-color:#eee;
    color:#666666;
    font-weight: bold;
    text-decoration: none;
    display: block;}
table.sortable span.sortarrow {
    color: black;
    text-decoration: none;}
label.h {
	display:inline;
	font-size:12px;
	font-weight:800;}
label {
	display:block;
	font-size:12px;
	font-weight:800;}
fieldset {
	padding:0;}
div.content {
	margin-left:5px;
	margin-right:5px;
	clear:both;}
.smaller {
	font-size:.8em;}
div.infoBox {
	background-color:#999999;
	color:#333333;
	font-size:smaller;
	padding:3px;}
.likeLink {
	cursor:pointer;
	color: blue;}
.likeLink:hover {
	text-decoration: underline;
	color: #CC0000;}
div.group {
	background-color:#EFEFEF;
	padding: 5px;
	border: 3px solid #EFEFEF;}
.controlButton {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#99CCFF;
	border-color: #336666;
	border:1px solid;
	padding:2px;
	text-align:center;
	cursor:hand;
	text-decoration: none;}
.linkButton {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#99CCFF;
	border-color: #336666;
	border:1px solid;
	padding:2px;
	text-align:center;}
body {
	font-family:arial,sans-serif;
	background-color:#FFFFFF;}
a:link {
	text-decoration: none; 
	color: blue;}
a:visited:hover {
	text-decoration: underline;
	color: #CC0000;}
a:visited {
	text-decoration: none;
	color:#660099;}
a:hover  {
	text-decoration: underline;
	color: #CC0000;}
a.novisit {
	color: blue;}
.evenRow {
	background-color:#E5E5E5;}
.oddRow {
	background-color:#F5F5F5;}
.indent{
	text-indent:-2em;
	padding-left:2em;
}
.notFound {
	color:red;
	font-style:italic;
	text-align:center;
	padding:2em;
}
.newRec {
	background-color:#D6F5F2;}
table.newRec {
	background-color: #D6F5F2;
	padding:0;
	border-spacing:0;}
input.savBtn {
   	color:	#666666;
   	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#FBD29B;
	border:1px solid;
	border-color: #336666;}
input.savBtn:hover {
	border-top-color:#FF6633 ;
	border-left-color:#FF6633 ;
	border-right-color:#FF6666 ;
	border-bottom-color:#FF6666 ;
	cursor:pointer;
} 
input.lnkBtn {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#99CCFF;
	border-color: #336666;
	border:1px solid;}
input.schBtn {
	color:#666666;
	font-size:10pt;
	font-weight:bold;
	font-family:Arial, Helvetica, sans-serif;
	background-color:#CCCC99;
	border-color:#336666;
	border:1px solid;}
input.clrBtn {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#FFCC00;
	border-color: #336666;
	border:1px solid;}
input.insBtn {
	color:	#666666;
	font-weight:bold;
	background-color:#99CCCC;
	border:1px solid #336666;}
input.insBtn:hover {
	border-top-color:#FF6633 ;
	border-left-color:#FF6633 ;
	border-right-color:#FF6666 ;
	border-bottom-color:#FF6666 ;
	cursor:pointer;
}
input.picBtn {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#CCCC99;
	border-color: #336666;
	border:1px solid;}
input.delBtn {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#FF9966;
	border-color: #336666;
	border:1px solid;}
input.qutBtn {
	color:	#666666;
	font-size:10pt;
	font-weight:bold;
	font-family: Arial, Helvetica, sans-serif;
	background-color:#FFFF00  ;
	border-color: #336666;
	border:1px solid;}
input.reqdClr, select.reqdClr, textarea.reqdClr {
   background-color:#FFFF33; }
input.badPick, select.badPick, textarea.badPick {
	background-color:#FF3366;}
input.goodPick, select.goodPick, textarea.goodPick {
	background-color:#8BFEB9;}	 
input.seleClr, select.seleClr, textarea.seleClr {
	background-color:#FF0000;}	 	
input.readClr, select.readClr {
	background-color:#CCCCCC;}
.btnhov {
	border-top-color:#FF6633 ;
	border-left-color:#FF6633 ;
	border-right-color:#FF6666 ;
	border-bottom-color:#FF6666 ;
	cursor:pointer;}
.external:after {
	text-decoration: none !important;
	content: "\a0" url(/images/linkOut.gif);
	}
a.external:link:after {
	text-decoration: none !important;
	content: "\a0" url(/images/linkOut.gif);
	}
a.external:hover:after {
	text-decoration: none !important;
	content: "\a0" url(/images/linkOutHover.gif);
	}
a.external:visited:after {
	text-decoration: none !important;
	content: "\a0" url(/images/linkOutVisited.gif);
	}
a.external:hover:visited:after {
	text-decoration: none !important;
	content: "\a0" url(/images/linkOutHover.gif);
	}
/*************************************************** Superfish ********************************************************/
.sf-menu, .sf-menu * {
	margin:			0;
	padding:		0;
	list-style:		none;
}
.sf-menu {
	line-height:	1.0;
}
.sf-menu ul {
	position:		absolute;
	top:			-999em;
	width:			10em; /* left offset of submenus need to match (see below) */
}
.sf-menu ul li {
	width:			100%;
}
.sf-menu li:hover {
	visibility:		inherit; /* fixes IE7 'sticky bug' */
}
.sf-menu li {
	float:			left;
	position:		relative;
}
.sf-menu a {
	display:		block;
	position:		relative;
}
.sf-menu li:hover ul,
.sf-menu li.sfHover ul {
	left:			0;
	top:			1.5em; /* match top ul list item height */
	z-index:		99;
}
ul.sf-menu li:hover li ul,
ul.sf-menu li.sfHover li ul {
	top:			-999em;
}
ul.sf-menu li li:hover ul,
ul.sf-menu li li.sfHover ul {
	left:			10em; /* match ul width */
	top:			0;
}
ul.sf-menu li li:hover li ul,
ul.sf-menu li li.sfHover li ul {
	top:			-999em;
}
ul.sf-menu li li li:hover ul,
ul.sf-menu li li li.sfHover ul {
	left:			10em; /* match ul width */
	top:			0;
}
/*** DEMO SKIN ***/
.sf-menu {
	float:			left;
	margin-bottom:	.1em;
}
.sf-menu a {
	border-left:	1px solid #fff;
	border-top:		1px solid #CFDEFF;
	padding: 		.25em 2em;
	text-decoration:none;
}
.sf-menu a, .sf-menu a:visited  { /* visited pseudo selector so IE6 applies text colour*/
	color:			#0000FF;
}
.sf-menu li {
	background:		#E7E7E7;
}
.sf-menu li li {
	background:		#E7E7E7;
}
.sf-menu li li li {
	background:		#E7E7E7;
}
.sf-menu li:hover, .sf-menu li.sfHover,
.sf-menu a:focus, .sf-menu a:hover, .sf-menu a:active {
	background:		#D0D0D0;
	outline:		0;
	color:red;
}
.sf-menu a.sf-with-ul {
	padding-right: 	2.25em;
	min-width:		1px; /* trigger IE7 hasLayout so spans position accurately */
}
.sf-sub-indicator {
	position:		absolute;
	display:		block;
	right:			.25em;
	top:			1.05em; /* IE6 only */
	width:			10px;
	height:			10px;
	text-indent: 	-999em;
	overflow:		hidden;
	background:		url('/images/css/arrows-ffffff.png') no-repeat -10px -100px; /* 8-bit indexed alpha png. IE6 gets solid image only */
}
a > .sf-sub-indicator {  /* give all except IE6 the correct values */
	top:			.6em;
	background-position: 0 -100px; /* use translucent arrow for modern browsers*/
}
/* apply hovers to modern browsers */
a:focus > .sf-sub-indicator,
a:hover > .sf-sub-indicator,
a:active > .sf-sub-indicator,
li:hover > a > .sf-sub-indicator,
li.sfHover > a > .sf-sub-indicator {
	background-position: -10px -100px; /* arrow hovers for modern browsers*/
}

/* point right for anchors in subs */
.sf-menu ul .sf-sub-indicator { background-position:  -10px 0; }
.sf-menu ul a > .sf-sub-indicator { background-position:  0 0; }
/* apply hovers to modern browsers */
.sf-menu ul a:focus > .sf-sub-indicator,
.sf-menu ul a:hover > .sf-sub-indicator,
.sf-menu ul a:active > .sf-sub-indicator,
.sf-menu ul li:hover > a > .sf-sub-indicator,
.sf-menu ul li.sfHover > a > .sf-sub-indicator {
	background-position: -10px 0; /* arrow hovers for modern browsers*/
}

/*** shadows for all but IE6 ***/
.sf-shadow ul {
	background:	url('/images/css/shadow.png') no-repeat bottom right;
	padding: 0 8px 9px 0;
	-moz-border-radius-bottomleft: 17px;
	-moz-border-radius-topright: 17px;
	-webkit-border-top-right-radius: 17px;
	-webkit-border-bottom-left-radius: 17px;
}
.sf-shadow ul.sf-shadow-off {
	background: transparent;
}
.sf-mainMenuWrapper { 
	clear:left;
	float:left;
	width:100%;
	font-size:small;
	font-weight:400;
	background:#E7E7E7;
	border-top:1px solid white;
}
/************************ dropdown taxonomy results *****************************/
div.submenu {
width:100%;
float: left;
}

div.submenu ul {
list-style: none;
margin: 0;
padding: 0;
width: 100%;
float: left;
}

div.submenu a, div.submenu h2 {
font: bold 11px/16px arial, helvetica, sans-serif;
display: block;
border-width: 1px;
border-style: solid;
border-color: #ccc #888 #555 #bbb;
margin: 0;
padding: 2px 3px;
}

div.submenu h2 {
color: #0000FF;
background:url(/images/small-black-down-arrow.gif) no-repeat 100% 100%;
cursor:pointer;
}

div.submenu a {
color: #0000FF;
background: #E7E7E7;
text-decoration: none;
}

div.submenu a:hover {
color: red;
}

div.submenu li {position: relative;}

div.submenu ul ul {
position: absolute;
z-index: 500;
}

div.submenu ul ul ul {
position: absolute;
top: 0;
left: 100%;
}

div.submenu ul ul,
div.submenu ul li:hover ul ul,
div.submenu ul ul li:hover ul ul
{display: none;}

div.submenu ul li:hover ul,
div.submenu ul ul li:hover ul,
div.submenu ul ul ul li:hover ul
{display: block;}

div.submenu h2:hover{
background:#E7E7E7 url(/images/small-black-down-arrow.gif) no-repeat 100% 100%;
color:#0000FF;
}
/*************************** jquery ui calendar ***************************/
/* stop relative (=huge) sizing */
div.ui-datepicker{font-size:10px;}
.ui-helper-hidden { display: none; }
.ui-helper-hidden-accessible { position: absolute; left: -99999999px; }
.ui-helper-reset { margin: 0; padding: 0; border: 0; outline: 0; line-height: 1.3; text-decoration: none; font-size: 100%; list-style: none; }
.ui-helper-clearfix:after { content: "."; display: block; height: 0; clear: both; visibility: hidden; }
.ui-helper-clearfix { display: inline-block; }
/* required comment for clearfix to work in Opera \*/
* html .ui-helper-clearfix { height:1%; }
.ui-helper-clearfix { display:block; }
/* end clearfix */
.ui-helper-zfix { width: 100%; height: 100%; top: 0; left: 0; position: absolute; opacity: 0; filter:Alpha(Opacity=0); }
.ui-state-disabled { cursor: default !important; }
.ui-icon { display: block; text-indent: -99999px; overflow: hidden; background-repeat: no-repeat; }
.ui-widget-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
.ui-widget { font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif; font-size: 1.1em; }
.ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button { font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif; font-size: 1em; }
.ui-widget-content { border: 1px solid #dddddd; background: #eeeeee url(/images/css/ui-bg_highlight-soft_100_eeeeee_1x100.png) 50% top repeat-x; color: #333333; }
.ui-widget-content a { color: #333333; }
.ui-widget-header { border: 1px solid #e78f08; background: #f6a828 url(/images/css/ui-bg_gloss-wave_35_f6a828_500x100.png) 50% 50% repeat-x; color: #ffffff; font-weight: bold; }
.ui-widget-header a { color: #ffffff; }
.ui-state-default, .ui-widget-content .ui-state-default { border: 1px solid #cccccc; background: #f6f6f6 url(/images/css/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #1c94c4; outline: none; }
.ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited { color: #1c94c4; text-decoration: none; outline: none; }
.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus { border: 1px solid #fbcb09; background: #fdf5ce url(/images/css/ui-bg_glass_100_fdf5ce_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #c77405; outline: none; }
.ui-state-hover a, .ui-state-hover a:hover { color: #c77405; text-decoration: none; outline: none; }
.ui-state-active, .ui-widget-content .ui-state-active { border: 1px solid #fbd850; background: #ffffff url(/images/css/ui-bg_glass_65_ffffff_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #eb8f00; outline: none; }
.ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited { color: #eb8f00; outline: none; text-decoration: none; }
.ui-state-highlight, .ui-widget-content .ui-state-highlight {border: 1px solid #fed22f; background: #ffe45c url(/images/css/ui-bg_highlight-soft_75_ffe45c_1x100.png) 50% top repeat-x; color: #363636; }
.ui-state-highlight a, .ui-widget-content .ui-state-highlight a { color: #363636; }
.ui-state-error, .ui-widget-content .ui-state-error {border: 1px solid #cd0a0a; background: #b81900 url(/images/css/ui-bg_diagonals-thick_18_b81900_40x40.png) 50% 50% repeat; color: #ffffff; }
.ui-state-error a, .ui-widget-content .ui-state-error a { color: #ffffff; }
.ui-state-error-text, .ui-widget-content .ui-state-error-text { color: #ffffff; }
.ui-state-disabled, .ui-widget-content .ui-state-disabled { opacity: .35; filter:Alpha(Opacity=35); background-image: none; }
.ui-priority-primary, .ui-widget-content .ui-priority-primary { font-weight: bold; }
.ui-priority-secondary, .ui-widget-content .ui-priority-secondary { opacity: .7; filter:Alpha(Opacity=70); font-weight: normal; }
.ui-icon { width: 16px; height: 16px; background-image: url(/images/css/ui-icons_222222_256x240.png); }
.ui-widget-content .ui-icon {background-image: url(/images/css/ui-icons_222222_256x240.png); }
.ui-widget-header .ui-icon {background-image: url(/images/css/ui-icons_ffffff_256x240.png); }
.ui-state-default .ui-icon { background-image: url(/images/css/ui-icons_ef8c08_256x240.png); }
.ui-state-hover .ui-icon, .ui-state-focus .ui-icon {background-image: url(/images/css/ui-icons_ef8c08_256x240.png); }
.ui-state-active .ui-icon {background-image: url(/images/css/ui-icons_ef8c08_256x240.png); }
.ui-state-highlight .ui-icon {background-image: url(/images/css/ui-icons_228ef1_256x240.png); }
.ui-state-error .ui-icon, .ui-state-error-text .ui-icon {background-image: url(/images/css/ui-icons_ffd27a_256x240.png); }

.ui-corner-tl { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; }
.ui-corner-tr { -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; }
.ui-corner-bl { -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; }
.ui-corner-br { -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; }
.ui-corner-top { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; }
.ui-corner-bottom { -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; }
.ui-corner-right {  -moz-border-radius-topright: 4px; -webkit-border-top-right-radius: 4px; -moz-border-radius-bottomright: 4px; -webkit-border-bottom-right-radius: 4px; }
.ui-corner-left { -moz-border-radius-topleft: 4px; -webkit-border-top-left-radius: 4px; -moz-border-radius-bottomleft: 4px; -webkit-border-bottom-left-radius: 4px; }
.ui-corner-all { -moz-border-radius: 4px; -webkit-border-radius: 4px; }

/* Overlays */
.ui-widget-overlay { background: #666666 url(/images/css/ui-bg_diagonals-thick_20_666666_40x40.png) 50% 50% repeat; opacity: .50;filter:Alpha(Opacity=50); }
.ui-widget-shadow { margin: -5px 0 0 -5px; padding: 5px; background: #000000 url(/images/css/ui-bg_flat_10_000000_40x100.png) 50% 50% repeat-x; opacity: .20;filter:Alpha(Opacity=20); -moz-border-radius: 5px; -webkit-border-radius: 5px; }
.ui-datepicker { width: 17em; padding: .2em .2em 0; }
.ui-datepicker .ui-datepicker-header { position:relative; padding:.2em 0; }
.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next { position:absolute; top: 2px; width: 1.8em; height: 1.8em; }
.ui-datepicker .ui-datepicker-prev-hover, .ui-datepicker .ui-datepicker-next-hover { top: 1px; }
.ui-datepicker .ui-datepicker-prev { left:2px; }
.ui-datepicker .ui-datepicker-next { right:2px; }
.ui-datepicker .ui-datepicker-prev-hover { left:1px; }
.ui-datepicker .ui-datepicker-next-hover { right:1px; }
.ui-datepicker .ui-datepicker-prev span, .ui-datepicker .ui-datepicker-next span { display: block; position: absolute; left: 50%; margin-left: -8px; top: 50%; margin-top: -8px;  }
.ui-datepicker .ui-datepicker-title { margin: 0 2.3em; line-height: 1.8em; text-align: center; }
.ui-datepicker .ui-datepicker-title select { float:left; font-size:1em; margin:1px 0; }
.ui-datepicker select.ui-datepicker-month-year {width: 100%;}
.ui-datepicker select.ui-datepicker-month, 
.ui-datepicker select.ui-datepicker-year { width: 49%;}
.ui-datepicker .ui-datepicker-title select.ui-datepicker-year { float: right; }
.ui-datepicker table {width: 100%; font-size: .9em; border-collapse: collapse; margin:0 0 .4em; }
.ui-datepicker th { padding: .7em .3em; text-align: center; font-weight: bold; border: 0;  }
.ui-datepicker td { border: 0; padding: 1px; }
.ui-datepicker td span, .ui-datepicker td a { display: block; padding: .2em; text-align: right; text-decoration: none; }
.ui-datepicker .ui-datepicker-buttonpane { background-image: none; margin: .7em 0 0 0; padding:0 .2em; border-left: 0; border-right: 0; border-bottom: 0; }
.ui-datepicker .ui-datepicker-buttonpane button { float: right; margin: .5em .2em .4em; cursor: pointer; padding: .2em .6em .3em .6em; width:auto; overflow:visible; }
.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current { float:left; }
.ui-datepicker-rtl { direction: rtl; }
.ui-datepicker-rtl .ui-datepicker-prev { right: 2px; left: auto; }
.ui-datepicker-rtl .ui-datepicker-next { left: 2px; right: auto; }
.ui-datepicker-rtl .ui-datepicker-prev:hover { right: 1px; left: auto; }
.ui-datepicker-rtl .ui-datepicker-next:hover { left: 1px; right: auto; }
.ui-datepicker-rtl .ui-datepicker-buttonpane { clear:right; }
.ui-datepicker-rtl .ui-datepicker-buttonpane button { float: left; }
.ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current { float:right; }
.ui-datepicker-rtl .ui-datepicker-group { float:right; }
.ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header { border-right-width:0; border-left-width:1px; }
.ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header { border-right-width:0; border-left-width:1px; }
.ui-datepicker-cover {
    display: none; /*sorry for IE5*/
    display/**/: block; /*sorry for IE5*/
    position: absolute; /*must have*/
    z-index: -1; /*must have*/
    filter: mask(); /*must have*/
    top: -4px; /*must have*/
    left: -4px; /*must have*/
    width: 200px; /*must have*/
    height: 200px; /*must have*/
}


.outer {
width:95%;
background-color:white;
}

.group {

}

.pair {
clear:both;

}

.subset {
	padding-left:2em;
	font-size:.9em;
}
.value {
float:right;
width:69%;
font-weight:600;
text-align:left;
}

.data {
float:left;
width:30%;
text-align:right;
}

.title{
font-weight:bold;
clear:both;
padding-top:3em;
padding-left:4em;
}

.data:after{
content: ": ";
}
</style>
<div class="infoLink" style="text-align:right;" onclick="removeDetail()">close</div>

	<div class="outer">
		<div class="group">
			
				<div class="title">
					Geography
				</div>
				
					<div class="pair">
						<div class="data">Continent/Ocean</div>

						<div class="value">North America</div>
					</div>
				
					<div class="pair">
						<div class="data">Country</div>
						<div class="value">United States</div>
					</div>
				
					<div class="pair">

						<div class="data">State/Province</div>
						<div class="value">Hawaii</div>
					</div>
				
					<div class="pair">
						<div class="data">County</div>
						<div class="value">Hawaii County</div>
					</div>

				
					<div class="pair">
						<div class="data">Source</div>
						<div class="value">University of Alaska Museum</div>
					</div>
				
		</div>
		
			<div class="group">
				
					<div class="title">
						Locality
					</div>

					
						<div class="pair">
							<div class="data">Specific Locality</div>
							<div class="value">1 MI W HONOKAA</div>
						</div>
					
			</div>
			
			<div class="group">
				
					<div class="title">
						
							Accepted Coordinates
						
					</div>

					
						<div class="pair">
							<div class="data">Decimal Latitude</div>
							<div class="value">12.0000000000</div>
						</div>
						<div class="pair">
							<div class="data">Decimal Longitude</div>
							<div class="value">34.0000000000</div>

						</div>
					
					<div class="pair">
						<div class="data">Datum</div>
						<div class="value">American Samoa 1962</div>
					</div>
					<div class="pair">
						<div class="data">Reference</div>

						<div class="value">fake</div>
					</div>
					<div class="pair">
						<div class="data">Reference</div>
						<div class="value">fake</div>
					</div>
					
					<div class="pair">

						<div class="data">Determiner</div>
						<div class="value">Dusty L. McDonald</div>
					</div>
					<div class="pair">
						<div class="data">Determined Date</div>
						<div class="value">01 Jan 2009</div>
					</div>

					<div class="pair">
						<div class="data">Method</div>
						<div class="value">BioGeoMancer</div>
					</div>
					<div class="pair">
						<div class="data">Verification Status</div>
						<div class="value">unverified</div>

					</div>
					
						<div class="pair">
							<div class="data">Method</div>
							<div class="value">BioGeoMancer</div>
						</div>
					
					<div class="title">
						
							Unaccepted Coordinates
						
					</div>

					
						<div class="pair">
							<div class="data">Decimal Latitude</div>
							<div class="value">20.0704803000</div>
						</div>
						<div class="pair">
							<div class="data">Decimal Longitude</div>
							<div class="value">-155.4786835000</div>

						</div>
					
					<div class="pair">
						<div class="data">Datum</div>
						<div class="value">World Geodetic System 1984</div>
					</div>
					<div class="pair">
						<div class="data">Reference</div>

						<div class="value">USGS Map</div>
					</div>
					<div class="pair">
						<div class="data">Reference</div>
						<div class="value">USGS Map</div>
					</div>
					
						<div class="pair">

							<div class="data">Error</div>
							<div class="value">2.382 mi</div>
						</div>
					
					<div class="pair">
						<div class="data">Determiner</div>
						<div class="value">Jason Young</div>
					</div>

					<div class="pair">
						<div class="data">Determined Date</div>
						<div class="value">25 Mar 2002</div>
					</div>
					<div class="pair">
						<div class="data">Method</div>
						<div class="value">not recorded</div>

					</div>
					<div class="pair">
						<div class="data">Verification Status</div>
						<div class="value">unverified</div>
					</div>
					
						<div class="pair">
							<div class="data">Method</div>

							<div class="value">not recorded</div>
						</div>
					
						<div class="pair">
							<div class="data">Remark</div>
							<div class="value">Measured at 1 mi (distance assumed by air) W from the geographical center of Honokaa to Hwy 19.; MaNIS Det. Ref.: Topo USA Pacific West v 3.0 DeLorme; Calculated from original decimal degrees</div>
						</div>
					
			</div>

			
				<div class="group">
					<div class="title">
						Collecting Event
					</div>
					
						<div class="pair">
							<div class="data">Geology Attribute</div>
							<div class="value">Series/Epoch</div>
						</div>

						<div class="pair subset">
							<div class="data">Attribute Value</div>
							<div class="value">woot</div>
						</div>
						
							<div class="pair subset">
								<div class="data">Determiner</div>
								<div class="value">Bob Ahgook</div>

							</div>
						
							<div class="pair subset">
								<div class="data">Method</div>
								<div class="value">eyeballs</div>
							</div>
						
							<div class="pair subset">
								<div class="data">Determined Date</div>

								<div class="value">1943-01-01 00:00:00.0</div>
							</div>
						
							<div class="pair subset">
								<div class="data">Remark</div>
								<div class="value">looky!</div>
							</div>
						
						<div class="pair">

							<div class="data">Geology Attribute</div>
							<div class="value">Stage/Age</div>
						</div>
						<div class="pair subset">
							<div class="data">Attribute Value</div>
							<div class="value">age is old</div>
						</div>

						
						<div class="pair">
							<div class="data">Geology Attribute</div>
							<div class="value">formation</div>
						</div>
						<div class="pair subset">
							<div class="data">Attribute Value</div>
							<div class="value">prince creek</div>

						</div>
						
				</div>
			
			<div class="group">
				
					<div class="title">
						Collecting Event
					</div>
			        <div class="pair">
						<div class="data">Date</div>
						<div class="value">23 Oct 1963</div>

					</div>
					
						<div class="pair">
							<div class="data">Verbatim Locality</div>
							<div class="value">W slope Mauna Kea, near Pu'u La'au doublequote--->" & two ""</div>
						</div>
					
						<div class="pair">
							<div class="data">Collecting Source</div>

							<div class="value">wild caught</div>
						</div>
					
			</div>
		
	</div>
