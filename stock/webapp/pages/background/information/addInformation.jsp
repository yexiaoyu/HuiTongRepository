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
	var editor = new UE.ui.Editor( {initialFrameWidth:910}  );
	editor.render("myEditor");
	editor.ready(function(){
	    editor.setContent("欢迎使用UEditor！");
	});

	$.formValidator.initConfig({ formid: "addUserForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#userName").formValidator({ onshow: "请输入用户名", onfocus: "用户名输入5-20个以字母开头、可带数字_.", oncorrect: "该用户名可以注册" })
		.inputValidator({min:5,max:20,onerror: "你输入的用户名非法,请确认"}).regexValidator({regexp:"^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$",onerror:"用户名格式不正确"})
		.ajaxValidator({
		    type : "get",
			url : rootPath + "/background/checkUserNameValid.do",
			addidvalue : true,
			datatype : "json",
			success : function(data){
	            if( data.pass == 1 ){
	                return true;
				}else{
	                return false;
				}
			},
			buttons: $("#formSubmit"),
			onerror : "该用户已注册，请重新输入",
			onwait : "正在校验验证码，请稍候..."
		});;
	$("#passWord").formValidator({ onshow: "请输入密码", onfocus: "输入5-20位密码", oncorrect: "输入正确" })
		.inputValidator({min:5,max:20,onerror: "请确认输入密码"});
	$("#passWord2").formValidator({ onshow: "请再次输入密码", onfocus: "再次输入密码", oncorrect: "输入正确" })
		.inputValidator({min:5,max:20,onerror: "请确认输入密码"}).functionValidator({
			fun:function(val,elem){
				var password = $("#passWord").val();
				if(val == password){
					return true;
				}else{
					return "两次密码输入不正确";
				}
			}
		});
	$("#gradeId").formValidator({ onshow: "请选择用户级别", onfocus: "请选择用户级别", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择用户级别"});
	$("#realName").formValidator({ onshow: "请输入姓名", onfocus: "输入2~5位姓名", oncorrect: "输入正确" })
		.inputValidator({min:2,max:5,onerror: "输入2~5位姓名"});
	$("#email").formValidator({ onshow: "请输入邮箱", onfocus: "请输入邮箱", oncorrect: "输入正确！" ,defaultvalue:"@"})
		.inputValidator({min:6,max:100,onerror:"你输入的邮箱长度非法,请确认"})
		.regexValidator({regexp:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$",onerror:"邮箱格式不正确"});
	$("#phone").formValidator({ onshow: "请输入手机号码", onfocus: "请输入手机号码", oncorrect: "输入正确！" })
		.inputValidator({min:11,max:11,onerror:"手机号码必须是11位的,请确认"})
		.regexValidator({regexp:"^0{0,1}(13[0-9]|145|147|15[0-3]|15[5-9]|18[0-9])[0-9]{8}$",onerror:"手机格式不正确"});
});
$("#formSubmit").click(function() {
	//验证通过提交数据
	if($.formValidator.pageIsValid('1')){
		var url = $("#addUserForm").attr("action");
		var data = $("#addUserForm").serialize();
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
		<s:hidden name="nodeName" value="addInformation"/>
		<s:hidden name="user.isValid" value="1"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" id="userName"/></td>
		    	<td ><div id="userNameTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">密码</td>
		    	<td class="t2"><s:password theme="simple" cssClass="textInput" name="user.passWord" id="passWord"/></td>
		    	<td ><div id="passWordTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">确认密码</td>
		    	<td class="t2"><s:password theme="simple" cssClass="textInput" name="passWord2" id="passWord2"/></td>
		    	<td ><div id="passWord2Tip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
				<td class="t1">用户级别</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="gradeIdTip" style="width:300px"></div></td>
			</tr>
			<tr>
		    	<td class="t1">真实姓名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.realName" id="realName"/></td>
		    	<td ><div id="realNameTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">Email邮箱</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.email" id="email"/></td>
		    	<td ><div id="emailTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">手机号码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.phone" id="phone"/></td>
		    	<td ><div id="phoneTip" style="width:300px"></div></td>
	    	</tr>
	    	<!-- <tr>
		    	<td class="t1">内容</td>
		    	<td colspan="2"><textarea id="myEditor" class="content" name="user.content"></textarea></td>
	    	</tr> -->
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td></tr>
    	</table>
	</form>
</div>
