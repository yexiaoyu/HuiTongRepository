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
	window.location.href=rootPath + "/background/operateNews.do?curpage="+curpage+"&pagesize="+pagesize+"&nodeName=query"; 
}
function deleteNews(id,title){
   	if(confirm("确认删除财经信息-" + title + "?")){
   		window.location.href=rootPath + "/background/operateNews.do?id="+id+"&nodeName=delete";
   	}
}
function updateNews(id){
	window.location.href=rootPath + "/background/operateNews.do?id="+id+"&nodeName=updateEntry";
}
</script>
</head>
<body>
<div class="loginForm">
	<div>
	<div class="topbar">新闻查询</div>
	<form action="operateNews.do" method="post" id="economicForm" namespace="/background">
		<s:hidden name="nodeName" value="query"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
		    	<td class="t1"><span>类型</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="news.type" list="typeMap" headerKey="" headerValue="请选择"/>
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
			<th width="20%">类型</th>
			<th width="20%">主题</th>
			<th width="20%">是否有效</th>
			<th width="20%">管理</th>
		</tr>
		<s:iterator value="newsList">
			<tr>
				<td><s:property value="typeName"/></td>
				<td><s:property value="title"/></td>
				<td>
					<s:if test="%{isValid == 1}">是</s:if>
					<s:elseif test="%{isValid == 0}">否</s:elseif>
				</td>
				<td><a href="#" onclick="deleteNews('${id}','${title }');">删除</a>&nbsp;&nbsp;<a href="#" onclick="updateNews(${id})">修改</a></td>
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