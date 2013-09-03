<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.js"></script>  
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/>  
<script type="text/javascript">
/*$(document).ready(function() {
	//这样设置宽度和高度
	var editor = new UE.ui.Editor( {initialFrameWidth:910}  );
	editor.render("myEditor");
	editor.ready(function(){
	    editor.setContent("欢迎使用UEditor！");
	});
});*/
$("#formSubmit").click(function() {
	//验证通过提交数据
	//if($.formValidator.pageIsValid('1')){
		var url = $("#addUserForm").attr("action");
		var data = $("#addUserForm").serialize();
		$.post(url, data, function(data) {
			$("#maincontent").html(data);
		});
	//}
	//菜单显示切换
	//$('#menu li').find(".light").removeClass("light");
	//$('#personList').addClass("light");
	return false;
});
</script>
<div class="loginForm">
<div class="topbar">添加用户</div>
	<form action="addUser.do" method="post" id="addUserForm" namespace="/background">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" /></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">密码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.passWord" /></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">确认密码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="passWord2" /></td>
	    	</tr>
	    	<tr>
				<td class="t1">用户级别</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
						listValue="gradeName" listKey="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
			</tr>
	    	<!-- <tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea id="myEditor" class="content" name="user.content"></textarea></td>
	    	</tr> -->
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td></tr>
    	</table>
	</form>
</div>
