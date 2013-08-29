<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="leftmenu">
<div class="mainside"><span>主界面</span></div>
<div class="childside">
<ul class="menulist">
	<li><a href="#">内参资讯</a></li>
	<li><a href="#">财政日历</a></li>
	<li><a href="#">财经要闻</a></li>
	<li><a href="#">个股预测</a></li>
	<li><a href="#">机构底牌</a></li>
</ul> 
</div>
</div>