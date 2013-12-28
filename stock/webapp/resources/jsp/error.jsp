<%@ page contentType="text/html; charset=utf-8"isErrorPage="true" %>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html>
<head>

<title>Error Page</title>
<%@ include file="taglibs.jsp"%> 

<style>
	td{font-size:9pt;}
.button_ty,.button_ty_over{color:#215b06;border:1px solid #7eb567;padding:1px 2px 1px 2px;height:20px;}
.button_ty{background: #fff url(${ctx}/pages/image/btbg_blue.gif) repeat-x left left -2px;}
.button_ty_over{background: #fff url(${ctx}/pages/image/btbg_orange.gif) repeat-x left left -2px;}
td.formtitle{	border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #a2d08f;	border-top-style: none;	background-color: #FFFFFF;	font-weight: bold;	color: #328400;	border-right-style: none;	border-left-style: none;	background-image: url(../pages/image/imgtop-green.gif);	background-repeat: no-repeat;	text-indent: 40px;	height:20px;	background-position: 10px center;	text-align:left;	padding-top: 3px;	margin-top: 10px;}
</style>
<script language="text/javascript">

function shContent()
{
  if(content.style.display=='')
    content.style.display = 'none';
  else
    content.style.display = '';
}

function closeIFrame() {
	if(document.parentWindow.name=="msgIFrame"){
	  var ifr = document.parentWindow.parent.document.getElementById("msgIFrame"); 
		document.parentWindow.parent.document.body.removeChild(ifr);
	}
}

function loadBody(){
  if(document.parentWindow.name=="msgIFrame"){
    trCloseButton.style.display = "";
  }
}
function closeMethod(){  
  if(parent!=null && parent.window!=null){
   
    if(parent.submitDlg!=null){
       parent.submitDlg.hide();
        if(parent.window._pageRefresh){
			parent.window._pageRefresh();
		 }
    }
 	else{
 	window.close();
 	}
  }else{
   	window.location="about:blank";
  }
}

function refreshMethod(){
	if(parent.submitDlg!=null){
		parent.submitDlg.hide();
		 if(parent.window._pageRefresh){
			parent.window._pageRefresh();
		 }
	}else{
		parent.window.close();
	}
}

</script>
</head>
<body onload="loadBody()">

  <table class="common" align="center">
    <tr>
      <td class="formtitle" colspan="2">系统提示:
      请联系***,联系方式：****</td>
    </tr>
    <tr id="trCloseButton" >
      <td colspan="2" align="center">
		<input type="button" value=" 关闭 " onclick="closeMethod();" class="button_ty">
		<input type="button" value=" 返回 " onclick="refreshMethod();" class="button_ty">
      </td>
    </tr>

  </table>

<div id="content" style="display:none">
	<table border="1">
		<tr>
			<th>request.getAttributeName</th>
			<th>request.getAttribute</th>
		</tr>
<%
		Enumeration enums =  request.getAttributeNames();
		while(enums.hasMoreElements()){
			String key = (String)enums.nextElement();
			//System.out.println("zzzzzzzzzzzzzzzzzzzzzzz   " + key);
			out.println( "<tr><td>");
			out.println( key );
			out.println( " </td><td>");
			out.println( request.getAttribute(key) );
			//System.out.println("ccccccccccccccccc  " + request.getAttribute(key));
			out.println( " </td></tr>");
		}
%>
	</table>

</div>
</body>
</html>