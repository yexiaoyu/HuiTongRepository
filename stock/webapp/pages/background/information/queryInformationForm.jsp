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
	<div class="topbar">股票查询</div>
	<form action="operateInformation.do" method="post" id="informationForm" namespace="/background">
		<s:hidden name="nodeName" value="queryInformation"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户级别</td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="information.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1">股票名称</td>
		    	<td class="t2">
		    		<s:select theme="simple" cssClass="selectInput" name="information.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td class="t1">是否有效</td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="information.isValid" 
		    		list="#{'0':'否','1':'是'}" headerKey="" headerValue="请选择"/></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">主题</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.title" /></td>
		    	<td class="t1">内容</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.content" /></td>
	    	</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="查询"/></td></tr>
    	</table>
	</form>
</div>