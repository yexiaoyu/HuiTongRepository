<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html>
<head>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
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
				loginForm.submit();
			}else{
				alert("验证输入不正确！");
				return false;
			}
		});
}
</script>
</head>
<body class="loginbody">
	<div class="leftbox">
	<form action="${ctx }/background/login" name="loginForm" id="loginForm" method="post"  target="_parent">
	<table class="formTable">
		<tr>
			<td class="t1"><span>用户名</span></td>
			<td colspan="2"><input class="textInput" name="j_username"  type="text" tabindex="1" /></td>
		</tr>
		<tr>
			<td class="t1"><span>登录密码</span></td>
			<td colspan="2"><input class="textInput" name="j_password" type="password" tabindex="2" /></td>
		</tr>
		<tr>
			<td class="t1" width="25%"><span>验证码</span></td>
			<td width="20%"><input class="yzmInput" name="checkCode" id="checkCode" type="text" value=""/></td>
			<td class="t2"><div id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg?rand='<%=Math.random() %>'" />
				</div><span><a href="javascript:refeshCode()">点击换图</a></span></td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</span></td>
			<td class="t2"><input id="_remember_me" name="_spring_security_remember_me" type="checkbox" value="on" /><span>下次自动登录</span></td>
			<td class="t2"><span><a href="#">忘记密码？</a></span></td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</td>
			<td class="t2"><input class="loginButton" type="button" value="" onclick="checkForm();" /></td> 
			<!-- <td class="t2"><input class="button01" type="submit" value="登录"  /></td>-->
			<td class="t3">&nbsp;</td>
		</tr>
		<tr>
			<td class="t1">&nbsp;</td>
			
			<td class="t3">&nbsp;</td>
		</tr>
	</table>
	</form>
	</div>
	<div class="rightbox">
		<div class="regbox">
	<b>还不是注册用户？</b><br />
	<br>
	<p><a class="resiternew" href="${ctx }/register.jsp">注册新用户</a></p>
	</div>
	</div>
</body>
</html>