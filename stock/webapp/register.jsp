<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<script type="text/javascript" src="${ctx}/resources/js/leftMenu.js"></script>
<style type="text/css">
.top { position:absolute; left:10px; top:10px; right:10px; height:50px; overflow:auto; background-color: #146fb9;}
.side { position:absolute; left:10px; top:70px; bottom:70px; width:200px; overflow:auto;}
.main { position:absolute; left:220px; top:70px; bottom:70px; right:220px; overflow:auto;}
.adside { position:absolute;right:10px; top:70px; bottom:70px; width:200px; overflow:auto;}
.bottom { position:absolute; left:10px; bottom:10px; right:10px; height:50px; overflow:auto;}
</style>
<script type="text/javascript">
//验证码刷新
function refeshCode() {
	$("#checkCode").val("");//刷新验证码的时候，把原来的清空
	var str = '<img align="absmiddle" border="0" height="22" width="66" src="' + rootPath + '/CaptchaImg?rand=' + Math.random() + '"/>';
	document.getElementById("codeImage").innerHTML = str;
}
function checkForm(){
	var checkCode = $("#checkCode").val();
	var result = true;
	$.post(rootPath + "/util/checkCodeValid.do",
		{checkCode : checkCode},
		function(data){
			var dataObj=eval("("+data+")");
			if(dataObj.pass == 1){
				//result = true;
				//alert("验证输入正确！");
				loginForm.submit();
			}else{
				alert("验证输入不正确！");
				return false;
			}
		});
	
	/*alert(result);
	if(result == true){
		var url = $("#loginForm").attr("action");
		var data = $("#loginForm").serialize();
		$.post(url, data, function(data) {
			//$("#nl").html(data);
			alert("登录成功");
		});
	}*/
	//return result;
}
$(document).ready(function (){
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
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#realName").formValidator({ onshow: "请输入姓名", onfocus: "输入2~5位姓名", oncorrect: "输入正确" })
		.inputValidator({min:2,max:5,onerror: "输入2~5位姓名"});
	$("#email").formValidator({ onshow: "请输入邮箱", onfocus: "请输入邮箱", oncorrect: "输入正确！" })
		.inputValidator({min:6,max:100,onerror:"你输入的邮箱长度非法,请确认"})
		.regexValidator({regexp:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$",onerror:"邮箱格式不正确"});
	$("#phone").formValidator({ onshow: "请输入手机号码", onfocus: "请输入手机号码", oncorrect: "输入正确！" })
		.inputValidator({min:11,max:11,onerror:"手机号码必须是11位的,请确认"})
		.regexValidator({regexp:"^0{0,1}(13[0-9]|145|147|15[0-3]|15[5-9]|18[0-9])[0-9]{8}$",onerror:"手机格式不正确"});
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
</script>
<title>股票内参系统</title>
</head>
<body>
<div class="top"><%@ include file="/resources/jsp/header.jsp"%></div>
<div class="side"></div>
<div class="main" id="maincontent">
<div class="content">
<div class="loginBox">
<div class="tt"><b>用户登录</b></div>
	<table>
	<tr>
	<td width="60%;">
	<div class="loginForm">
	<form action="register.do" method="post" id="addUserForm">
	<table class="tableLoginForm">
		<input type="hidden" name="user.isValid" value="1"/>
		<input type="hidden" name="nodeName" value="addUser"/>
		<input type="hidden" name="user.grade.gradeId" value="1"/><%--这里以后调整 --%>
			<tr>
		    	<td class="t1">用户名</td>
		    	<td class="t2"><input type="text" class="textInput" name="user.userName" id="userName"/></td>
		    	<td ><div id="userNameTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">密码</td>
		    	<td class="t2"><input type="password" class="textInput" name="user.passWord" id="passWord"/></td>
		    	<td ><div id="passWordTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">确认密码</td>
		    	<td class="t2"><input type="password" class="textInput" name="passWord2" id="passWord2"/></td>
		    	<td ><div id="passWord2Tip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">真实姓名</td>
		    	<td class="t2"><input type="text" class="textInput" name="user.realName" id="realName"/></td>
		    	<td ><div id="realNameTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">Email邮箱</td>
		    	<td class="t2"><input type="text" class="textInput" name="user.email" id="email"/></td>
		    	<td ><div id="emailTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">手机号码</td>
		    	<td class="t2"><input type="text" class="textInput" name="user.phone" id="phone"/></td>
		    	<td ><div id="phoneTip" style="width:300px"></div></td>
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
		    	<td><input class="button01" id="formSubmit" type="submit"  value="提交"/></td>
	    	</tr>
	</table>
	</form>
	</div>
		</td>
		<td>
	<div class="regbox">
	<p><b>我是注册用户？</b><br /></p>
	<p><a class="button02" href="${ctx }/login.jsp">登录</a></p>
	</div>
	</td>
	</tr>
	</table>
</div>
</div>
</div>
<div class="bottom"><%@ include file="/resources/jsp/footer.jsp"%></div>
</body>
</html>