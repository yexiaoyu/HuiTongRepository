<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html>
<head>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	window.location.href=rootPath + "/fore/operateInform.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=informPage"; 
}
</script>
</head>
<body>
<div class="topbar">
	<div class="grade"><a href="#">最新内参</a></div>
	<div class="grade"><a href="#">普通会员</a></div>
	<div class="grade"><a href="#">VIP会员</a></div>
</div>
<div class="notice"><span>温馨提示:</span><span style="color: red">每交易日早上9点更新，请注意查看。</span></div>
<div class="informContent">
<table class="listTable">
<tr>
	<th width="5%">序号</th>
	<th width="20%">股票</th>
	<th width="35%">主题</th>
	<th width="20%">时间</th>
	<th width="20%">操作</th>
</tr>
<s:iterator value="%{informList }" status="status">
	<tr>
		<td><s:property value='#status.index + 1'/></td>
		<td><s:property value="stockName"/></td>
		<td><a href="#"><s:property value="title"/></a></td>
		<td><fmt:formatDate value="${inputTime}" type="both" pattern="yyyy.MM.dd HH:mm:ss"/></td>
		<td><a href="#">【关注】</a></td>
	</tr>
</s:iterator>
</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>
</div>
</body>
</html>
