<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/leftMenu.js"></script>
<script type="text/javascript">
//验证码刷新
function refeshCode() {
	$("#checkCode").val("");//刷新验证码的时候，把原来的清空
	var str = '<img align="absmiddle" border="0" height="22" width="66" src="' + rootPath + '/CaptchaImg?rand=' + Math.random() + '"/>';
	document.getElementById("codeImage").innerHTML = str;
}
</script>
</head>
<body>
<div id="menu">
<div id="menu1">主界面</div>
<div id="menubr"></div>
<div id="menu2">
<ul id="menulist">
	<li class="item"><a href="${ctx }/fore/operateInform.do?nodeName=informIndex" target="bodycontent">内参资讯</a></li>
	<li class="item"><a href="${ctx }/fore/operateEconomic.do?nodeName=economicIndex" target="bodycontent">财政日历</a></li>
	<li class="item"><a href="${ctx }/fore/operateEconomic.do?nodeName=economicIndex&economic.isEvent=2" target="bodycontent">财经要闻</a></li>
	<li class="item"><a href="#">个股预测</a></li>
	<li class="item"><a href="#">机构底牌</a></li>
</ul>
</div>
</div>
</body>
</html>