<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/background/operateStock.do", { curpage: curpage, pagesize:pagesize ,nodeName : "queryStock"},
		function(data){
	    	$("#displyResult").html(data);
	   	});
}
function deleteStock(stockId,stockName,stockCode){
   	if(confirm("确认删除股票-" + stockCode + stockName + "?")){
   		$.post(rootPath + "/background/operateStock.do", { stockId : stockId ,nodeName : "deleteStock"},
			function(data){
		    	$("#displyResult").html(data);
		   	});
   	}
}
function updateStock(stockId){
	$.post(rootPath + "/background/operateStock.do", { stockId : stockId ,nodeName : "updateStockEntry"},
		function(data){
	    	$("#maincontent").html(data);
	   	});
}
</script>
	<table class="listTable">
	<tr>
		<th width="25%">股票代码</th>
		<th width="25%">股票名称</th>
		<th width="25%">是否有效</th>
		<th width="25%">管理</th>
	</tr>
	<s:iterator value="stockList">
		<tr>
			<td><s:property value="stockCode"/></td>
			<td><s:property value="stockName"/></td>
			<td><s:property value="isValid"/></td>
			<td><a href="#" onclick="deleteStock('${stockId}','${stockName }','${stockCode}');">删除</a><a href="#" onclick="updateStock(${stockId})">修改</a></td>
		</tr>
	</s:iterator>
	</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>