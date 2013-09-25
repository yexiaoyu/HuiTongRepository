<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
//分页
function queryPageList(){
	var curpage = $("#curpage").val();
	var pagesize = $("#pagesize").val();
	$.post(rootPath + "/fore/operateEconomic.do", { curpage: curpage, pagesize:pagesize ,nodeName : "queryEconomicPage"},
		function(data){
	    	$("#maincontent").html(data);
	   	});
}
</script>
<div class="topbar">
	<div class="grade"><a href="#">财经日历</a></div>
</div>
<div class="notice"><span>温馨提示:</span><span style="color: red">每交易日早上9点更新，请注意查看。</span></div>
<div class="informContent">
<table class="listTable">
<tr>
	<th width="5%">序号</th>
	<th width="12%">会议日期</th>
	<th width="12%">会议主题</th>
	<th width="12%">关联个股</th>
	<th width="12%">会议分类</th>
	<th width="12%">国内/国际</th>
	<th width="12%">影响类别</th>
	<th width="12%">影响时限</th>
	<th width="12%">备注</th>
</tr>
<s:iterator value="%{economicList }" status="status">
	<tr>
		<td><s:property value='#status.index + 1'/></td>
		<td><fmt:formatDate value="${time}" type="both" pattern="yyyy.MM.dd HH:mm:ss"/></td>
		<td><a href="#"><s:property value="topic"/></a></td>
		<td><s:property value="stock.stockCode"/><s:property value="stock.stockName"/></td>
		<td>
			<s:if test="%{meetingType == 1}">经济会议</s:if>
			<s:elseif test="%{meetingType == 2}">政治会议</s:elseif>
			<s:elseif test="%{meetingType == 3}">其他会议</s:elseif>
		</td>
		<td>
			<s:if test="%{isInland == 1}">国际</s:if>
			<s:elseif test="%{isInland == 2}">国内</s:elseif>
		</td>
		<td>
			<s:if test="%{impactType == 1}">利空</s:if>
			<s:elseif test="%{impactType == 2}">利好</s:elseif>
			<s:elseif test="%{impactType == 3}">中性</s:elseif>
		</td>
		<td><s:property value="impactLimit"/></td>
		<td><s:property value="remark"/></td>
	</tr>
</s:iterator>
</table>
<div class="Pagebg">
	<div class="page">
		<%@ include file="/resources/jsp/commonPage.jsp"%>
	</div>
</div>
</div>
