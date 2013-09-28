<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<script type="text/javascript">
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	window.location.href=rootPath + "/background/operateInformation.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=query"; 
}
function deleteInformation(informId,title){
   	if(confirm("确认删除内参-" + title + "?")){
   		window.location.href=rootPath + "/background/operateInformation.do?informId="+informId+"&nodeName=delete";
   	}
}
function updateInformation(informId){
	window.location.href=rootPath + "/background/operateInformation.do?informId="+informId+"&nodeName=updateEntry";
}
</script>
</head>
<body>
<div class="loginForm">
	<div class="topbar">内参查询</div>
	<form action="operateInformation.do" method="post" id="informationForm" namespace="/background">
		<s:hidden name="nodeName" value="query"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
		    	<td class="t1"><span>用户级别</span></td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="information.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1"><span>股票名称</span></td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="information.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1"><span>是否有效</span></td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="information.isValid" 
		    		list="#{'0':'否','1':'是'}" headerKey="" headerValue="请选择"/></td>
	    	</tr>
	    	<tr>
		    	<td class="t1"><span>主题</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.title" /></td>
		    	<td class="t1"><span>内容</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.content" /></td>
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
					<td><a href="${ctx }/background/operateInformation.do?informId=${informId}&nodeName=detail" target="_bank"><s:property value="title"/></a></td>
					<td>
						<s:if test="%{isValid == 1}">
						是
						</s:if>
						<s:elseif test="%{isValid == 0}">
						否
						</s:elseif>
					</td>
					<td><a href="#" onclick="deleteInformation('${informId}','${title }');">删除</a>&nbsp;&nbsp;<a href="#" onclick="updateInformation(${informId})">修改</a></td>
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