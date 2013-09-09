<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/background/operateInformation.do", { curpage: curpage, pagesize:pagesize ,nodeName : "queryInformation"},
		function(data){
	    	$("#displyResult").html(data);
	   	});
}
function deleteInformation(informId,title){
   	if(confirm("确认删除内参-" + title + "?")){
   		$.post(rootPath + "/background/operateInformation.do", { informId : informId ,nodeName : "deleteInformation"},
			function(data){
		    	$("#displyResult").html(data);
		   	});
   	}
}
function updateInformation(informId){
	$.post(rootPath + "/background/operateInformation.do", { informId : informId ,nodeName : "updateInformationEntry"},
		function(data){
	    	$("#maincontent").html(data);
	   	});
}
function detailInformation(informId){
	$.post(rootPath + "/background/operateInformation.do", { informId : informId ,nodeName : "detailInformation"},
			function(data){
		    	$("#maincontent").html(data);
		   	});
}
</script>
	<table class="listTable">
	<tr>
		<th width="20%">用户级别</th>
		<th width="20%">针对股票</th>
		<th width="20%">标题</th>
		<th width="20%">是否有效</th>
		<th width="20%">管理</th>
	</tr>
	<s:iterator value="informList">
		<tr>
			<td><s:property value="grade.gradeName"/></td>
			<td><s:property value="stock.stockCode"/><s:property value="stock.stockName"/></td>
			<!-- <td><a href="#" onclick="detailInformation(${informId});"><s:property value="title"/></a></td> -->
			<td><a href="${ctx }/background/operateInformation.do?informId=${informId}&nodeName=detailInformation" target="_bank"><s:property value="title"/></a></td>
			<td>
				<s:if test="%{isValid == 1}">
				是
				</s:if>
				<s:elseif test="%{isValid == 0}">
				否
				</s:elseif>
			</td>
			<td><a href="#" onclick="deleteInformation('${informId}','${title }');">删除</a><a href="#" onclick="updateInformation(${informId})">修改</a></td>
		</tr>
	</s:iterator>
	</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>