<%@ page contentType="text/html; charset=utf-8"%>
<div class="leftmenu">
<div class="mainside"><span>主界面</span></div>
<div class="childside">
<ul id="menu">
	<li class="item"><a href="#">用户管理</a>
		<ul class="optiton" id="opt_1">
			<li class="light"><a href="#" onclick="addUserEntry();">添加用户</a></li>
			<li><a href="#">查询用户</a></li>
		</ul>
	</li>
	<li class="item"><a href="#">股票管理</a>
		<ul class="optiton" id="opt_2">
			<li><a href="#">添加股票</a></li>
			<li><a href="#">股票用户</a></li>
		</ul>
	</li>
</ul> 
</div>
</div>
<script type="text/javascript">
function addUserEntry(){
	$.post(rootPath + "/background/addUserEntry.do",{},
			function(data){
				$("#maincontent").html(data);
			});
}
</script>