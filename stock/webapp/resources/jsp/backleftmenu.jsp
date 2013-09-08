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
	<li class="item"><a href="#">内参信息管理</a>
		<ul class="optiton" id="opt_3">
			<li id="addInform"><a href="#">添加内参信息</a></li>
			<li id="queryInform"><a href="#">查询内参信息</a></li>
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
</script>