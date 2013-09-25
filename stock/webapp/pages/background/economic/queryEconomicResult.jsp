<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/background/operateEconomic.do", { curpage: curpage, pagesize:pagesize ,nodeName : "queryEconomic"},
		function(data){
	    	$("#displyResult").html(data);
	   	});
}
function deleteEconomic(economicId,title){
   	if(confirm("确认删除内参-" + title + "?")){
   		$.post(rootPath + "/background/operateEconomic.do", { economicId : economicId ,nodeName : "deleteEconomic"},
			function(data){
		    	$("#displyResult").html(data);
		   	});
   	}
}
function updateEconomic(economicId){
	$.post(rootPath + "/background/operateEconomic.do", { economicId : economicId ,nodeName : "updateEconomicEntry"},
		function(data){
	    	$("#maincontent").html(data);
	   	});
}
function detailEconomic(economicId){
	$.post(rootPath + "/background/operateEconomic.do", { economicId : economicId ,nodeName : "detailEconomic"},
			function(data){
		    	$("#maincontent").html(data);
		   	});
}
</script>
	<table class="listTable">
	<tr>
		<th width="20%">关联个股</th>
		<th width="20%">是否有效</th>
		<th width="20%">管理</th>
	</tr>
	<s:iterator value="economicList">
		<tr>
			<td><s:property value="stock.stockCode"/><s:property value="stock.stockName"/></td>
			<!-- <td><a href="#" onclick="detailEconomic(${economicId});"><s:property value="title"/></a></td> 
			<td><a href="${ctx }/background/operateEconomic.do?economicId=${economicId}&nodeName=detailEconomic" target="_bank"><s:property value="title"/></a></td>-->
			<td>
				<s:if test="%{isValid == 1}">是</s:if>
				<s:elseif test="%{isValid == 0}">否</s:elseif>
			</td>
			<td><a href="#" onclick="deleteEconomic('${economicId}','${title }');">删除</a><a href="#" onclick="updateEconomic(${economicId})">修改</a></td>
		</tr>
	</s:iterator>
	</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>