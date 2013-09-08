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
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#checkCode").formValidator({ onshow: "请输入验证码！", onfocus: "请输入验证码！", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入验证码！"}).ajaxValidator({
		    type : "get",
			url : rootPath + "/util/checkCodeValid.do",
			addidvalue : true,
			datatype : "json",
			success : function(data){
	            if( data.pass == 1 ){
	                return true;
				}
	            else{
	            	alert("验证码输入错误！");
	                return false;
				}
			},
			buttons: $("#formSubmit"),
			onerror : "验证码输入错误！",
			onwait : "正在校验验证码，请稍候..."
		}); 
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
		<s:if test="%{nodeName == 'updateStockEntry' }">
			<s:hidden name="nodeName" value="updateStock"/>
			<s:hidden name="stock.stockId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addStockEntry' }">
			<s:hidden name="nodeName" value="addStock"/>
			<s:hidden name="stock.isValid" value="1"/>
		</s:elseif>
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
	    	<s:if test="%{nodeName == 'updateStockEntry' }">
		    	<tr>
			    	<td class="t1">是否有效</td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="stock.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
	    	</s:if>
	    	<tr>
				<td class="t1">验证码</td>
				<td class="t2"><input class="yzmInput" name="checkCode" id="checkCode" type="text" />
					<span id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg" />
					</span> <a href="javascript:refeshCode()">点击换图</a></td>
				<td><div id="checkCodeTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td>
	    	</tr>
    	</table>
	</form>
</div>
