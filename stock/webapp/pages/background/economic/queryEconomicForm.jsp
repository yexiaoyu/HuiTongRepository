<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
$("#formSubmit").click(function() {
	//验证通过提交数据
	//if($.formValidator.pageIsValid('1')){
		var url = $("#informationForm").attr("action");
		var data = $("#informationForm").serialize();
		$.post(url, data, function(data) {
			$("#displyResult").html(data);
		});
	//}
	//菜单显示切换
	//$('#menu li').find(".light").removeClass("light");
	//$('#personList').addClass("light");
	return false;
});
</script>
<div>
	<div class="topbar">财经查询</div>
	<form action="operateEconomic.do" method="post" id="economicForm" namespace="/background">
		<s:hidden name="nodeName" value="queryEconomic"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">会议/事件</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isEvent" list="#{'1':'财经会议','2':'财经事件'}" id="isEvent" headerKey="" headerValue="请选择"/>
				</td>
		    	<td class="t1">关联个股</td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="economic.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1">是否有效</td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="economic.isValid" 
		    		list="#{'0':'否','1':'是'}" headerKey="" headerValue="请选择"/></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">国内/国际</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isInland" list="#{'1':'国际','2':'国内'}" id="isInland" headerKey="" headerValue="请选择"/>
				</td>
		    	<td class="t1">会议分类</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.meetingType" list="#{'1':'经济会议','2':'政治会议','3':'其他会议'}" id="meetingType" headerKey="" headerValue="请选择"/>
				</td>
	    	</tr>
	    	<tr>
	    		<td class="t1">影响类别</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.impactType" list="#{'1':'利空','2':'利好','3':'中性'}" id="impactType" headerKey="" headerValue="请选择"/>
				</td>
				<td class="t1">日期</td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput Wdate" name="economic.time" id="time" onclick="WdatePicker()" readonly="readonly"/>
				</td>
	    	</tr>
	    	<tr>
		    	<td class="t1">主题</td>
			    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.topic" id="title"/></td>
		    	</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="查询"/></td></tr>
    	</table>
	</form>
</div>