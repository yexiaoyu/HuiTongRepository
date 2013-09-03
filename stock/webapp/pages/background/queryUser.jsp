<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.js"></script>  
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/>  
<script type="text/javascript">
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
<div class="topbar">用户查询</div>
	<form action="queryUser.do" method="post" id="queryUserForm" namespace="/background">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" /></td>
	    	</tr>
			<td class="t1">用户级别</td>
			<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
					listValue="gradeName" listKey="gradeId"
				 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
			</td>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="查询"/></td></tr>
    	</table>
	</form>
	<div class="displyUser">
	<table>
	<tr>
		<th>用户名</th>
		<th>用户等级</th>
		<th>真实姓名</th>
		<th>邮箱</th>
		<th>手机</th>
		<th>注册时间</th>
	</tr>
	<tr>
		<s:iterator value="">
		
		</s:iterator>
	</tr>
	</table>
	</div>
</div>
