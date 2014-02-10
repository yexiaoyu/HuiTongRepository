<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/DatePicker/WdatePicker.js"></script>
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
	/*$("#title").formValidator({ onshow: "请输入主题", onfocus: "请输入主题", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入主题"});
	$("#type").formValidator({ onshow: "请选择类型", onfocus: "请选择类型", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择类型"});
	$("#content").formValidator({ onshow: "请输入内容", onfocus: "请输入内容", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入内容"});*/
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
		addNewsForm.submit();
	}else{
		return false;
	}
}
function changeUpType(obj){
	$('#childType #1').hide();
	$('#childType #s1').attr("disabled",true); 
	$('#childType #s2').attr("disabled",true); 
	$('#childType #s3').attr("disabled",true); 
	$('#childType #2').hide();
	$('#childType #3').hide();
	$('#childType #s'+obj.value+'').attr("disabled",false); 
	$('#childType #'+obj.value+'').show();
}
</script>
</head>
<body>
<div class="loginForm">
<div class="topbar">添加新闻信息</div>
	<form action="operateNews.do" method="post" id="addNewsForm" namespace="/background">
		<s:if test="%{nodeName == 'updateEntry' }">
			<s:hidden name="nodeName" value="update"/>
			<s:hidden name="news.id"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addEntry' }">
			<s:hidden name="nodeName" value="add"/>
			<s:hidden name="news.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
			<!-- <tr>
				<td class="t1"><span>父类型</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" onchange="changeUpType(this);" list="#{'1':'热点资讯','2':'财经要闻','3':'内参资讯'}" id="upType" value="1" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="upTypeTip" style="width:300px"></div></td>
			</tr>
			<tr id="childType">
				<td class="t1"><span>子类型</span></td>
				<td class="t2" id="1">
				<s:select theme="simple" cssClass="selectInput" name="news.type" list="#{'1':'市场热点','2':'概念热点','3':'公司资讯','4':'全球资讯','5':'要闻资讯','6':'涨停板掘金'}" id="s1" headerKey="" headerValue="请选择"/>
				</td>
				<td class="t2" id="2" style="display: none">
				<s:select theme="simple" cssClass="selectInput" name="news.type" list="#{'7':'最新要闻','8':'概念要闻','9':'财经日历'}" id="s2" headerKey="" headerValue="请选择" disabled="true"/>
				</td>
				<td class="t2" id="3" style="display: none">
				<s:select theme="simple" cssClass="selectInput" name="news.type" list="#{'10':'最新资讯','11':'普通资讯','12':'VIP资讯'}" id="s3" headerKey="" headerValue="请选择" disabled="true"/>
				</td>
			</tr> -->
			<tr>
				<td class="t1"><span>新闻类型</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="news.type" list="typeMap" id="typeMap" listKey="key" listValue="value"  headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="typeMapTip" style="width:300px"></div></td>
			</tr>
			<s:if test="%{nodeName == 'updateEntry' }">
				<tr>
			    	<td class="t1"><span>是否有效</span></td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="news.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
			</s:if>
	    	<tr>
		    	<td class="t1"><span>主题</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="news.title" id="title"/></td>
		    	<td ><div id="titleTip" style="width:300px"></div></td>
	    	</tr>
	    	<%--<tr>
		    	<td class="t1">内容摘要</td>
		    	<td colspan="2"><textarea  name="news.shortContent" id="shortContent"></textarea></td>
		    	<td ><div id="shortContentTip" style="width:300px"></div></td>
	    	</tr>
	    	--%><tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea  name="news.content" id="content">${news.content }</textarea></td>
		    	<td ><div id="contentTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
				<td class="t1"><span>备注</span></td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="news.remark" id="remark"/>
				</td>
		    	<td ><div id="remarkTip" style="width:300px"></div></td>
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