<%@ page contentType="text/html; charset=utf-8"%>
<div class="leftmenu">
<div class="mainside"><span>主界面</span></div>
<div class="childside">
<ul id="menu">
	<li class="item"><a href="#" onclick="informIndex();">内参资讯</a></li>
	<li class="item"><a href="#" onclick="economicIndex();">财政日历</a></li>
	<li class="item"><a href="#" onclick="economicKeyIndex();">财经要闻</a></li>
	<li class="item"><a href="#">个股预测</a></li>
	<li class="item"><a href="#">机构底牌</a></li>
</ul>
</div>
</div>
<script type="text/javascript">
function informIndex(){
	$.post(rootPath + "/fore/operateInform.do",{nodeName : "informIndex"},
		function(data){
			$("#maincontent").html(data);
		});
}
function economicIndex(){
	$.post(rootPath + "/fore/operateEconomic.do",{nodeName : "economicIndex"},
		function(data){
			$("#maincontent").html(data);
		});
}
function economicKeyIndex(){
	$.post(rootPath + "/fore/operateEconomic.do",{nodeName : "economicIndex" , 'economic.isEvent' : '2'},
		function(data){
			$("#maincontent").html(data);
		});
}
//验证码刷新
function refeshCode() {
	$("#checkCode").val("");//刷新验证码的时候，把原来的清空
	var str = '<img align="absmiddle" border="0" height="22" width="66" src="' + rootPath + '/CaptchaImg?rand=' + Math.random() + '"/>';
	document.getElementById("codeImage").innerHTML = str;
}
</script>