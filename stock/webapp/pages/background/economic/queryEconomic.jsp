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
	window.location.href=rootPath + "/background/operateEconomic.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=query"; 
}
function deleteEconomic(economicId,title){
   	if(confirm("确认删除财经信息-" + title + "?")){
   		window.location.href=rootPath + "/background/operateEconomic.do?economicId="+economicId+"&nodeName=delete";
   	}
}
function updateEconomic(economicId){
	window.location.href=rootPath + "/background/operateEconomic.do?economicId="+economicId+"&nodeName=updateEntry";
}
</script>
</head>
<body>
<div class="loginForm">
	<div>
	<div class="topbar">财经查询</div>
	<form action="operateEconomic.do" method="post" id="economicForm" namespace="/background">
		<s:hidden name="nodeName" value="query"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
		    	<td class="t1"><span>会议/事件</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isEvent" list="#{'1':'财经会议','2':'财经事件'}" id="isEvent" headerKey="" headerValue="请选择"/>
				</td>
		    	<td class="t1"><span>关联个股</span></td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="economic.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1"><span>是否有效</span></td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="economic.isValid" 
		    		list="#{'0':'否','1':'是'}" headerKey="" headerValue="请选择"/></td>
	    	</tr>
	    	<tr>
		    	<td class="t1"><span>国内/国际</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isInland" list="#{'1':'国际','2':'国内'}" id="isInland" headerKey="" headerValue="请选择"/>
				</td>
		    	<td class="t1"><span>会议分类</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.meetingType" list="#{'1':'经济会议','2':'政治会议','3':'其他会议'}" id="meetingType" headerKey="" headerValue="请选择"/>
				</td>
	    	</tr>
	    	<tr>
	    		<td class="t1"><span>影响类别</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.impactType" list="#{'1':'利空','2':'利好','3':'中性'}" id="impactType" headerKey="" headerValue="请选择"/>
				</td>
				<td class="t1"><span>日期</span></td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput Wdate" name="economic.time" id="time" onclick="WdatePicker()" readonly="readonly"/>
				</td>
	    	</tr>
	    	<tr>
		    	<td class="t1"><span>主题</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.topic" id="title"/></td>
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
			<th width="20%">关联个股</th>
			<th width="20%">是否有效</th>
			<th width="20%">管理</th>
		</tr>
		<s:iterator value="economicList">
			<tr>
				<td><s:property value="stock.stockCode"/><s:property value="stock.stockName"/></td>
				<td>
					<s:if test="%{isValid == 1}">是</s:if>
					<s:elseif test="%{isValid == 0}">否</s:elseif>
				</td>
				<td><a href="#" onclick="deleteEconomic('${economicID}','${title }');">删除</a>&nbsp;&nbsp;<a href="#" onclick="updateEconomic(${economicID})">修改</a></td>
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