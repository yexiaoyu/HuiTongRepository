<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/> 
<script type="text/javascript" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" src="${ctx }/ueditor/ueditor.all.js"></script> 
<script type="text/javascript">
$(document).ready(function (){
	//这样设置宽度和高度
	var editor = new UE.ui.Editor( {initialFrameWidth:600}  );
	editor.render("content");
	editor.ready(function(){
	    editor.setContent($('#content').val());
	});

	$.formValidator.initConfig({ formid: "addInformForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#gradeId").formValidator({ onshow: "请选择用户级别", onfocus: "请选择用户级别", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择用户级别"});
	$("#stockCode").formValidator({ onshow: "请选择股票", onfocus: "请选择股票", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择股票"});
	$("#title").formValidator({ onshow: "请输入主题", onfocus: "请输入主题", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入主题"});
	$("#content").formValidator({ onshow: "", onfocus: "请输入内容", oncorrect: "输入正确" })
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
//验证码刷新
function refeshCode() {
	$("#checkCode").val("");//刷新验证码的时候，把原来的清空
	var str = '<img align="absmiddle" border="0" height="22" width="66" src="' + rootPath + '/CaptchaImg?rand=' + Math.random() + '"/>';
	document.getElementById("codeImage").innerHTML = str;
}
function checkForm() {
	//验证通过提交数据
	if($.formValidator.pageIsValid('1')){
		addInformForm.submit();
	}else{
		return false;
	}
}
</script>
</head>
<body>
<div class="loginForm">
<div class="topbar">添加内参信息</div>
	<form action="operateInformation.do" method="post" id="addInformForm" namespace="/background">
		<s:if test="%{nodeName == 'updateEntry' }">
			<s:hidden name="nodeName" value="update"/>
			<s:hidden name="information.informId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addEntry' }">
			<s:hidden name="nodeName" value="add"/>
			<s:hidden name="information.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
	    	<tr>
				<td class="t1"><span>用户级别</span></td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="information.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="gradeIdTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1"><span>针对股票</span></td>
				<td class="t2">
					<!-- <s:select theme="simple" cssClass="selectInput" name="information.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select> -->
					 <s:textfield theme="simple" cssClass="textInput" name="information.stockName" id="stockCode"/>
				</td>
		    	<td ><div id="stockCodeTip" style="width:300px"></div></td>
			</tr>
			<s:if test="%{nodeName == 'updateEntry' }">
				<tr>
			    	<td class="t1"><span>是否有效</span></td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="information.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
			</s:if>
	    	<tr>
		    	<td class="t1"><span>主题</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="information.title" id="title"/></td>
		    	<td ><div id="titleTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1"><span>内容</span></td>
		    	<td colspan="3"><textarea  class="content" name="information.content" id="content">${information.content}</textarea></td>
		    	<s:hidden id="contentHidden" value="%{information.content}"/>
	    	</tr>
	    	<tr>
				<td class="t1"><span>验证码</span></td>
				<td class="t2"><div id="yzmdiv"><input class="yzmInput" name="checkCode" id="checkCode" type="text" value=""/></div>
				<div id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg?rand='<%=Math.random() %>'" />
					</div><span><a href="javascript:refeshCode()">点击换图</a></span></td>
				<td><div id="checkCodeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
	    		<td>&nbsp;</td>
	    		<td><input class="resiternew" id="formSubmit" type="button" value="提交" onclick="checkForm();"/>
	    		<input class="resiternew" id="reset" type="reset" value="重置"/></td>
	    	</tr>
    	</table>
	</form>
</div>
</body>
</html>