<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<link rel="stylesheet" type="text/css" href="${ctx }/ueditor/themes/default/css/ueditor.css"/> 
<script type="text/javascript" src="${ctx }/ueditor/ueditor.config.js"></script>  
<script type="text/javascript" src="${ctx }/ueditor/ueditor.parse.js"></script>  
<script type="text/javascript" src="${ctx }/ueditor/ueditor.all.js"></script>  
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script> 
<script type="text/javascript">
$(document).ready(function (){
	//这样设置宽度和高度
	/*var editor = new UE.ui.Editor( {initialFrameWidth:600}  );
	editor.render("content");
	editor.ready(function(){
	    editor.setContent("在此输入内容");
	});*/

	$.formValidator.initConfig({ formid: "addInformForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#title").formValidator({ onshow: "请输入主题", onfocus: "请输入主题", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入主题"});
	$("#stockCode").formValidator({ onshow: "请选择股票", onfocus: "请选择股票", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择股票"});
	/*$("#content").formValidator({ onshow: "请输入内容", onfocus: "请输入内容", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入内容"});*/
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#isEvent").formValidator({ onshow: "请选择会议/事件", onfocus: "请选择会议/事件", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择会议/事件"});
	$("#isInland").formValidator({ onshow: "请选择国内/国际", onfocus: "请选择国内/国际", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择国内/国际"});
	$("#meetingType").formValidator({ onshow: "请选择会议分类", onfocus: "请选择会议分类", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择会议分类"});
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
$("#formSubmit").click(function() {
	//验证通过提交数据
	if($.formValidator.pageIsValid('1')){
		var url = $("#addEconomicForm").attr("action");
		var data = $("#addEconomicForm").serialize();
		$.post(url, data, function(data) {
			$("#maincontent").html(data);
		});
	}
	//菜单显示切换
	$('#menu li').find(".light").removeClass("light");
	$('#queryEconomic').addClass("light");
	return false;
});
</script>
<div class="loginForm">
<div class="topbar">添加财经信息</div>
	<form action="operateEconomic.do" method="post" id="addEconomicForm" namespace="/background">
		<s:if test="%{nodeName == 'updateEconomicEntry' }">
			<s:hidden name="nodeName" value="updateEconomic"/>
			<s:hidden name="Economic.informId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addEconomicEntry' }">
			<s:hidden name="nodeName" value="addEconomic"/>
			<s:hidden name="economic.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
			<tr>
				<td class="t1">会议/事件</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isEvent" list="#{'1':'财经会议','2':'财经事件'}" id="isEvent" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="isEventTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1">国内/国际</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.isInland" list="#{'1':'国际','2':'国内'}" id="isInland" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="isInlandTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1">会议分类</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.meetingType" list="#{'1':'经济会议','2':'政治会议','3':'其他会议'}" id="meetingType" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="meetingTypeTip" style="width:300px"></div></td>
			</tr>
			<tr>
				<td class="t1">影响类别</td>
				<td class="t2">
				<s:select theme="simple" cssClass="selectInput" name="economic.impactType" list="#{'1':'利空','2':'利好','3':'中性'}" id="impactType" headerKey="" headerValue="请选择"/>
				</td>
		    	<td ><div id="impactTypeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1">关联股票</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="economic.stock.stockId" 
						listValue="stockName" listKey="stockId" id="stockCode"
					 	list="stockList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="stockCodeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1">日期</td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput Wdate" name="economic.time" id="time" onclick="WdatePicker()" readonly="readonly"/>
				</td>
		    	<td ><div id="timeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
				<td class="t1">影响时长</td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.impactLimit" id="impactLimit"/>
				</td>
		    	<td ><div id="impactLimitTip" style="width:300px"></div></td>
			</tr>
			<s:if test="%{nodeName == 'updateEconomicEntry' }">
				<tr>
			    	<td class="t1">是否有效</td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="economic.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
			</s:if>
	    	<tr>
		    	<td class="t1">主题</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.topic" id="title"/></td>
		    	<td ><div id="titleTip" style="width:300px"></div></td>
	    	</tr>
	    	<!-- <tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea  class="content" name="economic.content" id="content"></textarea></td>
		    	<td ><div id="contentTip" style="width:300px"></div></td>
	    	</tr> -->
	    	<tr>
				<td class="t1">备注</td>
				<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="economic.remark" id="remark"/>
				</td>
		    	<td ><div id="remarkTip" style="width:300px"></div></td>
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
