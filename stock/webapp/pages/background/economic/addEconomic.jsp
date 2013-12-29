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
	    editor.setContent("");
	});

	$.formValidator.initConfig({ formid: "addInformForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#title").formValidator({ onshow: "请输入主题", onfocus: "请输入主题", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入主题"});
	$("#stockCode").formValidator({ onshow: "请输入关联个股", onfocus: "请输入关联个股", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入关联个股"});
	/*$("#content").formValidator({ onshow: "请输入内容", onfocus: "请输入内容", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入内容"});*/
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#isEvent").formValidator({ onshow: "请选择会议/事件", onfocus: "请选择会议/事件", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择会议/事件"});
	$("#isInland").formValidator({ onshow: "请选择国内/国际", onfocus: "请选择国内/国际", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择国内/国际"});
	/*$("#meetingType").formValidator({ onshow: "请选择会议分类", onfocus: "请选择会议分类", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择会议分类"});*/
	$("#impactType").formValidator({ onshow: "请选择影响类别", onfocus: "请选择影响类别", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择影响类别"});
	$("#time").formValidator({ onshow: "请选择日期", onfocus: "请选择日期", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择日期"});
	$("#impactLimit").formValidator({ onshow: "请输入影响时长", onfocus: "请输入影响时长", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入影响时长"});
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
		addEconomicForm.submit();
	}else{
		return false;
	}
}
</script>
</head>
<body>
<div class="loginForm">
<div class="topbar">添加财经信息</div>
	<form action="operateEconomic.do" method="post" id="addEconomicForm" namespace="/background">
		<s:if test="%{nodeName == 'updateEntry' }">
			<s:hidden name="nodeName" value="update"/>
			<s:hidden name="economic.informId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addEntry' }">
			<s:hidden name="nodeName" value="add"/>
			<s:hidden name="economic.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="formTable">
			<tr>
				<td class="t1"><span>会议/事件</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isEvent" list="#{'1':'财经会议','2':'财经事件'}" id="isEvent" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="isEventTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1"><span>国内/国际</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isInland" list="#{'1':'国际','2':'国内'}" id="isInland" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="isInlandTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1"><span>会议分类</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.meetingType" list="#{'1':'经济会议','2':'政治会议','3':'其他会议'}" id="meetingType" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="meetingTypeTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1"><span>影响类别</span></td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.impactType" list="#{'1':'利空','2':'利好','3':'中性'}" id="impactType" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="impactTypeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1"><span>关联股票</span></td>
				<td class="t2">
					<!-- <s:select theme="simple" cssClass="selectInput" name="economic.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select> -->
					 <s:textfield theme="simple" cssClass="textInput" name="economic.stockName" id="stockCode"/>
				</td>
		    	<td ><div id="stockCodeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1"><span>日期</span></td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput Wdate" name="economic.time" id="time" onclick="WdatePicker()" readonly="readonly"/>
				</td>
		    	<td ><div id="timeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1"><span>影响时长</span></td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.impactLimit" id="impactLimit"/>
				</td>
		    	<td ><div id="impactLimitTip" style="width:300px"></div></td>
			</tr>
			<s:if test="%{nodeName == 'updateEntry' }">
				<tr>
			    	<td class="t1"><span>是否有效</span></td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="economic.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
			</s:if>
	    	<tr>
		    	<td class="t1"><span>主题</span></td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.topic" id="title"/></td>
		    	<td ><div id="titleTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea  class="content" name="economic.content" id="content"></textarea></td>
		    	<td ><div id="contentTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
				<td class="t1"><span>备注</span></td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.remark" id="remark"/>
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