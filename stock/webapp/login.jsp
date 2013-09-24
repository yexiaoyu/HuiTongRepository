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
	<form action="${ctx }/login" name="loginForm" id="loginForm" method="post">
	<table class="tableLoginForm">
		<tr>
			<td class="t1">用户名</td>
			<td class="t2"><input class="textInput" name="j_username"  type="text" tabindex="1" /></td>
			<!--		<td class="t3"><span class="ts1">&nbsp;</span></td>-->
		</tr>
		<tr>
			<td class="t1">登录密码</td>
			<td class="t2"><input class="pwInput" name="j_password" type="password" tabindex="2" /></td>
		</tr>
		<tr>
			<td class="t1">验证码</td>
			<td class="t2"><input class="yzmInput" name="checkCode" id="checkCode" type="text" value=""/>
				<span id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg?rand='<%=Math.random() %>'" />
				</span> <a href="javascript:refeshCode()">点击换图</a></td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</td>
			<td class="t2"><input id="_remember_me" name="_spring_security_remember_me" type="checkbox" value="on" />&nbsp;让系统记住我</td>
			<td class="t3">&nbsp;</td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</td>
			<td class="t2"><input class="button01" type="button" value="登录" onclick="checkForm();" /></td>
			<td class="t3">&nbsp;</td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</td>
			<td class="t2"><a href="#">忘记密码？</a></td>
			<td class="t3">&nbsp;</td>
		</tr>
	</table>
	</form>
	</div>
		</td>
		<td>
	<div class="regbox">
	<p><b>还不是注册用户？</b><br />
	立即注册，立即享受即时了解股票信息。</p>
	<p><a class="button02" href="#">注册新用户</a></p>
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


