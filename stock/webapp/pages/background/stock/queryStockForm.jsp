<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
$("#formSubmit").click(function() {
	//验证通过提交数据
	//if($.formValidator.pageIsValid('1')){
		var url = $("#stockForm").attr("action");
		var data = $("#stockForm").serialize();
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
	<form action="operateStock.do" method="post" id="stockForm" namespace="/background">
		<s:hidden name="nodeName" value="queryStock"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">股票代码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockCode" /></td>
		    	<td class="t1">股票名称</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockName" /></td>
		    	<td class="t1">是否有效</td>
		    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="stock.isValid" list="#{'0':'否','1':'是'}"/></td>
	    	</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="查询"/></td></tr>
    	</table>
	</form>
</div>