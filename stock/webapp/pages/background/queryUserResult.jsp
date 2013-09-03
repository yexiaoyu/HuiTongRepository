<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/background/queryUser.do", { curpage: curpage, pagesize:pagesize},
	function(data){
    	$("#displyUser").html(data);
   	});
}
</script>
	<table class="listTable">
	<tr>
		<th width="14%">用户名</th>
		<th width="14%">用户等级</th>
		<th width="14%">真实姓名</th>
		<th width="14%">邮箱</th>
		<th width="14%">手机</th>
		<th width="14%">注册时间</th>
		<th width="14%">管理</th>
	</tr>
	<s:iterator value="userList">
		<tr>
			<td><s:property value="userName"/></td>
			<td><s:property value="grade.gradeName"/></td>
			<td><s:property value="realName"/></td>
			<td><s:property value="email"/></td>
			<td><s:property value="phone"/></td>
			<td><fmt:formatDate value="${registTime}" type="both" pattern="yyyy.MM.dd"/></td>
			<td><a href="#">删除</a><a href="#">修改</a></td>
		</tr>
	</s:iterator>
	</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>