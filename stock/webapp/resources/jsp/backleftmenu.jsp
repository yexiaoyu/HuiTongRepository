<%@ page contentType="text/html; charset=utf-8"%>
<div class="leftmenu">
<div class="mainside"><span>主界面</span></div>
<div class="childside">
<ul id="menu">
	<li class="item"><a href="#">用户管理</a>
		<ul class="optiton" id="opt_1">
			<li class="light" id="addUser"><a href="#" onclick="addUserEntry();">添加用户</a></li>
			<li id="queryUser"><a href="#" onclick="queryUserEntry();">查询用户</a></li>
		</ul>
	</li>
	<li class="item"><a href="#">股票管理</a>
		<ul class="optiton" id="opt_2">
			<li id="addStock"><a href="#" onclick="addStockEntry();">添加股票</a></li>
			<li id="queryStock"><a href="#" onclick="queryStockEntry();">查询股票</a></li>
		</ul>
	</li>
	<li class="item"><a href="#">内参管理</a>
		<ul class="optiton" id="opt_3">
			<li id="addInform"><a href="#" onclick="addInformEntry();">添加内参</a></li>
			<li id="queryInform"><a href="#" onclick="queryInformEntry();">查询内参</a></li>
		</ul>
	</li>
</ul> 
</div>
</div>
<script type="text/javascript">
function addUserEntry(){
	$.post(rootPath + "/background/operateUser.do",{nodeName : "addUserEntry"},
		function(data){
			$("#maincontent").html(data);
		});
}
function queryUserEntry(){
	$.post(rootPath + "/background/operateUser.do",{nodeName : "queryUserEntry"},
		function(data){
			$("#maincontent").html(data);
		});
}
function addStockEntry(){
	$.post(rootPath + "/background/operateStock.do",{nodeName : "addStockEntry"},
		function(data){
			$("#maincontent").html(data);
		});
}
function queryStockEntry(){
	$.post(rootPath + "/background/operateStock.do",{nodeName : "queryStockEntry"},
		function(data){
			$("#maincontent").html(data);
		});
}
function addInformEntry(){
	$.post(rootPath + "/background/operateInformation.do",{nodeName : "addInformationEntry"},
		function(data){
			$("#maincontent").html(data);
		});
}
function queryInformEntry(){
	$.post(rootPath + "/background/operateInformation.do",{nodeName : "queryInformationEntry"},
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