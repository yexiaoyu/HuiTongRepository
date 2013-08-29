<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>  
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.parse.js"></script>  
	<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.js"></script>  
	<link rel="stylesheet" type="text/css" href="ueditor/themes/default/css/ueditor.css"/>  
	<style type="text/css">
		#myEditor{width:500px;}
	</style>
	
	<script type="text/javascript">
	function onready(){
		//这样设置宽度和高度
		var editor = new UE.ui.Editor( {initialFrameWidth:910}  );// initialFrameWidth : 600,initialFrameHeight: 600
		editor.render("myEditor");
		editor.ready(function(){
		    editor.setContent("欢迎使用UEditor！");
		});   
	}
	</script>

  </head>
  
  <body onload="onready()">
  <form action="login.do" method="post">
    <table>
    	<tr>
	    	<th>用户名</th>
	    	<td><input type="text" name="user.userName" /></td>
    	</tr>
    	<tr>
	    	<th>密码</th>
	    	<td><input type="password" name="user.passWord" /></td>
    	</tr>
    	<tr>
	    	<th>确认密码</th>
	    	<td><input type="password" name="passWord2" /></td>
    	</tr>
    	<tr>
	    	<th>内容</th>
    	</tr>
    	<tr>
	    	<td colspan="2"><textarea id="myEditor" class="content" name="user.content"></textarea></td>
    	</tr>
    	<tr><td><input type="submit"/></td></tr>
    </table>
  </form>
  </body>
</html>
