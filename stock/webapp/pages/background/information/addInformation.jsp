<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" charset="utf-8" src="${ctx }/ueditor/ueditor.all.js"></script>  
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/> 

<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script> 
<script type="text/javascript">
$(document).ready(function (){
	//这样设置宽度和高度
	var editor = new UE.ui.Editor( {initialFrameWidth:600}  );
	editor.render("content");
	editor.ready(function(){
	    editor.setContent("在此输入内容");
	});

	$.formValidator.initConfig({ formid: "addInformForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#gradeId").formValidator({ onshow: "请选择用户级别", onfocus: "请选择用户级别", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择用户级别"});
	$("#stockCode").formValidator({ onshow: "请选择股票", onfocus: "请选择股票", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择股票"});
	$("#title").formValidator({ onshow: "请输入主题", onfocus: "请输入主题", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入主题"});
	$("#content").formValidator({ onshow: "请输入内容", onfocus: "请输入内容", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入内容"});
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#checkCode").formValidator({ onshow: "请输入验证码！", onfocus: "请输入验证码！", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入验证码！"}).ajaxValidator({
		    type : "get",
			url : rootPath + "/util/checkCodeValid.do",
			addidvalue : true,
			//data : "checkCode="+$("#checkCodeId").val(),
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
		var url = $("#addInformForm").attr("action");
		var data = $("#addInformForm").serialize();
		$.post(url, data, function(data) {
			$("#maincontent").html(data);
		});
	}
	//菜单显示切换
	$('#menu li').find(".light").removeClass("light");
	$('#queryUser').addClass("light");
	return false;
});
</script>
<div class="loginForm">
<div class="topbar">添加内参信息</div>
	<form action="operateInformation.do" method="post" id="addInformForm" namespace="/background">
		<s:if test="%{nodeName == 'updateInformationEntry' }">
			<s:hidden name="nodeName" value="updateInformation"/>
			<s:hidden name="information.informId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addInformationEntry' }">
			<s:hidden name="nodeName" value="addInformation"/>
			<s:hidden name="information.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
				<td class="t1">用户级别</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="information.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="gradeIdTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1">针对股票</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="information.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="stockCodeTip" style="width:300px"></div></td>
			</tr>
			<s:if test="%{nodeName == 'updateInformationEntry' }">
				<tr>
			    	<td class="t1">是否有效</td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="information.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
			</s:if>
	    	<tr>
		    	<td class="t1">主题</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.title" id="title"/></td>
		    	<td ><div id="titleTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea  class="content" name="information.content" id="content"></textarea></td>
		    	<td ><div id="contentTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
				<td class="t1">验证码</td>
				<td class="t2"><input class="yzmInput" name="checkCode" id="checkCode" type="text" />
					<span id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg?rand='<%=Math.random() %>'" />
					</span> <a href="javascript:refeshCode()">点击换图</a></td>
				<td><div id="checkCodeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td></tr>
    	</table>
	</form>
</div>
