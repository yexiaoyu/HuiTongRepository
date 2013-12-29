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

var lastFaqClick=null;
window.onload=function(){
  var faq=document.getElementById("faq");
  var dls=faq.getElementsByTagName("dl");
  for (var i=0,dl;dl=dls[i];i++){
    var dt=dl.getElementsByTagName("dt")[0];//取得标题
     dt.id = "faq_dt_"+(Math.random()*100);
     dt.onclick=function(){
       var p=this.parentNode;//取得父节点
        if (lastFaqClick!=null&&lastFaqClick.id!=this.id){
          var dds=lastFaqClick.parentNode.getElementsByTagName("dd");
          for (var i=0,dd;dd=dds[i];i++)
            dd.style.display='none';
        }
        lastFaqClick=this;
        var dds=p.getElementsByTagName("dd");//取得对应子节点，也就是说明部分
        var tmpDisplay='none';
        if (gs(dds[0],'display')=='none')
          tmpDisplay='block';
        for (var i=0;i<dds.length;i++)
          dds[i].style.display=tmpDisplay;
      }
  }
}

function gs(d,a){
  if (d.currentStyle){
    var curVal=d.currentStyle[a]
  }else{
    var curVal=document.defaultView.getComputedStyle(d, null)[a]
  }
  return curVal;
}
</script>
</head>
<body>
<div id="menu">
<div id="menu1">主界面</div>
<div id="menubr"></div>
<div id="menub">
<ul id="faq">
	<li class="item">
		<!-- <ul class="optiton" id="opt_1">
			<li class="light" id="addUser"><a href="#" onclick="addUserEntry();">添加用户</a></li>
			<li id="queryUser"><a href="#" onclick="queryUserEntry();">查询用户</a></li>
		</ul> -->
		<dl>
			<dt><span class="menum">用户管理</span></dt>
			<dd><a href="${ctx }/background/operateUser.do?nodeName=addEntry" target="bodycontent">添加用户</a></dd>
			<dd><a href="${ctx }/background/operateUser.do?nodeName=queryEntry" target="bodycontent">查询用户</a></dd>
		</dl>
	</li>
	<%--<li class="item"><!--<a href="#">股票管理</a>
		<ul class="optiton" id="opt_2">
			<li id="addStock"><a href="#" onclick="addStockEntry();">添加股票</a></li>
			<li id="queryStock"><a href="#" onclick="queryStockEntry();">查询股票</a></li>
		</ul>-->
		<dl>
			<dt><span class="menum">股票管理</span></dt>
			<dd><a href="${ctx }/background/operateStock.do?nodeName=addEntry" target="bodycontent">添加股票</a></dd>
			<dd><a href="${ctx }/background/operateStock.do?nodeName=queryEntry" target="bodycontent">查询股票</a></dd>
		</dl>
	</li> --%>
	<li class="item"><!--<a href="#">内参管理</a>
		<ul class="optiton" id="opt_3">
			<li id="addInform"><a href="#" onclick="addInformEntry();">添加内参</a></li>
			<li id="queryInform"><a href="#" onclick="queryInformEntry();">查询内参</a></li>
		</ul>-->
		<dl>
			<dt><span class="menum">内参管理</span></dt>
			<dd><a href="${ctx }/background/operateInformation.do?nodeName=addEntry" target="bodycontent">添加内参</a></dd>
			<dd><a href="${ctx }/background/operateInformation.do?nodeName=queryEntry" target="bodycontent">查询内参</a></dd>
		</dl>
	</li>
	<li class="item"><!--<a href="#">财经管理</a>
		<ul class="optiton" id="opt_3">
			<li id="addEconomic"><a href="#" onclick="addEconomicEntry();">添加财经</a></li>
			<li id="queryEconomic"><a href="#" onclick="queryEconomicEntry();">查询财经</a></li>
		</ul>-->
		<dl>
			<dt><span class="menum">财经管理</span></dt>
			<dd><a href="${ctx }/background/operateEconomic.do?nodeName=addEntry" target="bodycontent">添加财经</a></dd>
			<dd><a href="${ctx }/background/operateEconomic.do?nodeName=queryEntry" target="bodycontent">查询财经</a></dd>
		</dl>
	</li>
	<li class="item">
		<dl>
			<dt><span class="menum">新闻管理</span></dt>
			<dd><a href="${ctx }/background/operateNews.do?nodeName=addEntry" target="bodycontent">添加新闻</a></dd>
			<dd><a href="${ctx }/background/operateNews.do?nodeName=queryEntry" target="bodycontent">查询新闻</a></dd>
		</dl>
	</li>
</ul> 
</div>
</div>
</body>
</html>