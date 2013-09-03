<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
$("#formSubmit").click(function() {
	//验证通过提交数据
	//if($.formValidator.pageIsValid('1')){
		var url = $("#queryUserForm").attr("action");
		var data = $("#queryUserForm").serialize();
		$.post(url, data, function(data) {
			$("#displyUser").html(data);
		});
	//}
	//菜单显示切换
	//$('#menu li').find(".light").removeClass("light");
	//$('#personList').addClass("light");
	return false;
});
</script>
<div>
	<div class="topbar">用户查询</div>
	<form action="queryUser.do" method="post" id="queryUserForm" namespace="/background">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" /></td>
				<td class="t1">用户级别</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
						listValue="gradeName" listKey="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
	    	</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="查询"/></td></tr>
    	</table>
	</form>
</div>