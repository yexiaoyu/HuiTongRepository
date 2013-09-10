<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script> 
<script type="text/javascript">
//验证码刷新
function refeshCode() {
	$("#checkCode").val("");//刷新验证码的时候，把原来的清空
	var str = '<img align="absmiddle" border="0" height="22" width="66" src="' + rootPath + '/CaptchaImg?rand=' + Math.random() + '"/>';
	document.getElementById("codeImage").innerHTML = str;
}
</script>
</head>
<!-- content -->
<div class="content">
<div class="loginBox">
<div class="tt"><b>注册新用户</b></div>
<div class="loginForm">
<form action="/clientLogin.do" name="loginForm" method="post" onsubmit="return checkForm();">
<table class="tableLoginForm">
	<tr>
		<td class="t1">用户名</td>
		<td class="t2"><input class="textInput" name="username"  type="text" tabindex="1" /></td>
		<!--		<td class="t3"><span class="ts1">&nbsp;</span></td>-->
	</tr>
	<tr>
		<td class="t1">登录密码</td>
		<td class="t2"><input class="pwInput" name="password" type="password" tabindex="2" /></td>
	</tr>
	<tr>
		<td class="t1">验证码</td>
		<td class="t2"><input class="yzmInput" name="checkCode" id="checkCode" type="text" />
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
		<td class="t2"><input class="button01" type="submit" value="登录" onclick="this.form.onsubmit();" /></td>
		<td class="t3">&nbsp;</td>
	</tr>
	<tr>
		<td class="t1">&nbsp;</td>
		<td class="t2"><a href="<c:url value="/online/forgetPS.jsp"></c:url>">忘记密码？</a></td>
		<td class="t3">&nbsp;</td>
	</tr>
</table>
</form>
</div>

<div class="regbox">
<p><b>我已经是注册用户！</b><br />
登录后，立即享受即时了解股票信息。</p>
<p><a class="button02" href=''>注册新用户</a></p>
</div>
</div>
</div>
<!-- content end -->
