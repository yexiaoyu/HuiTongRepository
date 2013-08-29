<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.js"></script>  
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/>  
<script type="text/javascript">
$(document).ready(function() {
	//这样设置宽度和高度
	var editor = new UE.ui.Editor( {initialFrameWidth:910}  );
	editor.render("myEditor");
	editor.ready(function(){
	    editor.setContent("欢迎使用UEditor！");
	});
});
</script>
<div class="loginForm">
	<form action="" method="post" name="adduser" namespace="/background">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><input type="text" class="textInput" name="user.userName" /></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">密码</td>
		    	<td class="t2"><input type="password" class="textInput" name="user.passWord" /></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">确认密码</td>
		    	<td class="t2"><input type="password" class="textInput" name="passWord2" /></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea id="myEditor" class="content" name="user.content"></textarea></td>
	    	</tr>
	    	<tr><td><input type="submit"/></td></tr>
    	</table>
	</form>
</div>
