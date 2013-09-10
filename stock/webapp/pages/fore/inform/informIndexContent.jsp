<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/fore/operateInform.do", { curpage: curpage, pagesize:pagesize ,nodeName : "queryInformPage"},
		function(data){
	    	$("#informContent").html(data);
	   	});
}
</script>
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
		<td><s:property value="stock.stockCode"/><s:property value="stock.stockName"/></td>
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