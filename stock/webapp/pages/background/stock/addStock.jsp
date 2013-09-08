<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script> 
<script type="text/javascript">
$(document).ready(function (){
	$.formValidator.initConfig({ formid: "addUserForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#stockCode").formValidator({ onshow: "请输入股票代码", onfocus: "请输入股票代码", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请确认股票代码"});
	$("#stockName").formValidator({ onshow: "请股票名称", onfocus: "请股票名称", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请股票名称"});
});
$("#formSubmit").click(function() {
	//验证通过提交数据
	if($.formValidator.pageIsValid('1')){
		$("#formSubmit").attr({"disabled":"disabled"});
		var url = $("#stockForm").attr("action");
		var data = $("#stockForm").serialize();
		$.post(url, data, function(data) {
			$("#maincontent").html(data);
		});
	}
	//菜单显示切换
	$('#menu li').find(".light").removeClass("light");
	$('#queryStock').addClass("light");
	return false;
});
</script>
<div class="loginForm">
<div class="topbar">添加股票</div>
	<form action="operateStock.do" method="post" id="stockForm" namespace="/background">
		<s:hidden name="nodeName" value="addStock"/>
		<s:hidden name="stock.isValid" value="1"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">股票代码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockCode" id="stockCode"/></td>
		    	<td ><div id="stockCodeTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">股票名称</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="stock.stockName" id="stockName"/></td>
		    	<td ><div id="stockNameTip" style="width:300px"></div></td>
	    	</tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td></tr>
    	</table>
	</form>
</div>
