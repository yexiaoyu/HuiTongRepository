<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.top { position:absolute; left:10px; top:10px; right:10px; height:50px; overflow:auto; background-color: #146fb9;}
.side { position:absolute; left:10px; top:70px; bottom:70px; width:200px; overflow:auto;}
.main { position:absolute; left:220px; top:70px; bottom:70px; right:220px; overflow:auto;}
.adside { position:absolute;right:10px; top:70px; bottom:70px; width:200px; overflow:auto;}
.bottom { position:absolute; left:10px; bottom:10px; right:10px; height:50px; overflow:auto;}
</style>
<title>div仿框架布局 - 加上滚动条，一个div仿3框架的基础概型已经完成</title>
</head>
<body>
<div class="top"><%@ include file="/resources/jsp/header.jsp"%></div>
<div class="side"><%@ include file="/resources/jsp/leftmenu.jsp"%></div>
<div class="main">
<br /><br /><br />加上滚动条，一个div仿框架的基础概型已经完成
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</div>
<div class="adside"><span  style="font-size: 3em;">广告</span><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /></div>
<div class="bottom"><%@ include file="/resources/jsp/footer.jsp"%></div>
</body>
</html>


