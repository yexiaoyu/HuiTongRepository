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
	window.location.href=rootPath + "/background/operateStock.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=query"; 
}
function deleteStock(stockId,stockName,stockCode){
   	if(confirm("确认删除股票-" + userName + "?")){
   		window.location.href=rootPath + "/background/operateStock.do?stockId="+stockId+"&nodeName=delete";
   	}
}
function updateStock(stockId){
	window.location.href=rootPath + "/background/operateStock.do?stockId="+stockId+"&nodeName=updateEntry";
}
</script>
</head>
<body>
<div class="loginForm">
	<div>
	<div class="topbar">股票查询</div>
	<form action="operateStock.do" method="post" id="stockForm" namespace="/background">
		<s:hidden name="nodeName" value="query"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
		    	<td class="t1"><span>股票代码</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockCode" /></td>
		    	<td class="t1"><span>股票名称</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockName" /></td>
		    	<td class="t1"><span>是否有效</span></td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="stock.isValid" list="#{'0':'否','1':'是'}" headerKey="" headerValue="请选择"/></td>
	    	</tr>
	    	<tr>
	    		<td colspan="6" style="text-align: center;"><input class="resiternew" type="submit" value="查询"/></td>
	    	</tr>
    	</table>
	</form>
	</div>
	<div class="resultDiv">查询结果</div>
	<div id="displyResult">
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
				<td>
					<s:if test="%{isValid == 1}">
					是
					</s:if>
					<s:elseif test="%{isValid == 0}">
					否
					</s:elseif>
				</td>
				<td><a href="#" onclick="deleteStock('${stockId}','${stockName }','${stockCode}');">删除</a>&nbsp;&nbsp;<a href="#" onclick="updateStock(${stockId})">修改</a></td>
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