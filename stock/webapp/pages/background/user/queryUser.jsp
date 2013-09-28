<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<script type="text/javascript">
//分页
function queryPageList(){
   	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	window.location.href=rootPath + "/background/operateUser.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=query"; 
}
function deleteUser(userId,userName){
   	if(confirm("确认删除用户-" + userName + "?")){
   		window.location.href=rootPath + "/background/operateUser.do?userId="+userId+"&nodeName=delete";
   	}
}
function updateUser(userId){
	window.location.href=rootPath + "/background/operateUser.do?userId="+userId+"&nodeName=updateEntry";
}
</script>
</head>
<body>
<div class="loginForm">
	<div>
	<div class="topbar">用户查询</div>
	<form action="operateUser.do" method="post" id="queryUserForm" namespace="/background">
		<s:hidden name="nodeName" value="query"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
		    	<td class="t1"><span>用户名</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" /></td>
				<td class="t1"><span>用户级别</span></td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
						listValue="gradeName" listKey="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
	    	</tr>
	    	<tr>
	    		<td colspan="4" style="text-align: center;"><input class="resiternew" type="submit" value="查询"/></td>
	    	</tr>
    	</table>
		</form>
	</div>
	<div class="resultDiv">查询结果</div>
	<div id="displyResult">
		<table class="listTable">
		<tr>
			<th width="14%">用户名</th>
			<th width="14%">用户等级</th>
			<th width="14%">真实姓名</th>
			<th width="14%">邮&nbsp;&nbsp;箱</th>
			<th width="14%">手&nbsp;&nbsp;机</th>
			<th width="14%">注册时间</th>
			<th width="14%">管&nbsp;&nbsp;理</th>
		</tr>
		<s:iterator value="userList">
			<tr>
				<td>${userName }</td>
				<td>${grade.gradeName }</td>
				<td>${realName }</td>
				<td>${email }</td>
				<td>${phone }</td>
				<td><fmt:formatDate value="${registTime}" type="both" pattern="yyyy.MM.dd"/></td>
				<td><a href="#" onclick="deleteUser('${userId}','${userName}');">删除</a>&nbsp;&nbsp;<a href="#" onclick="updateUser('${userId }');">修改</a></td>
			</tr>
		</s:iterator>
		</table>
		<div class="Pagebg">
			<div class="page">
				<%@ include file="/resources/jsp/commonPage.jsp"%>
			</div>
		</div>
	</div>
</div>
</body>
</html>