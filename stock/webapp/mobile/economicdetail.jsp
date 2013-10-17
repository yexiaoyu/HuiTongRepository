<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/resources/jsp/taglibs.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta charset="utf-8">
<title>财经首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="jscss/jquery-mobile/jquery.mobile-1.3.1.css" rel="stylesheet" type="text/css"/>
<script src="jscss/jquery-mobile/jquery-1.8.2.js" type="text/javascript"></script>
<script src="jscss/jquery-mobile/jquery.mobile-1.3.1.js" type="text/javascript"></script>
<style type="text/css">
#submit{float:right; margin:10px;}
#toregist{float:left; margin:10px;}
</style>
</head> 
<body> 
<div data-role="page">
        <div data-role="header" data-position="fixed" >
        	<h1>财经日历详情</h1>
        </div>
        <div data-role="content">
        <table>
        	<tr><td width="20%">会议日期</td><td width="80%"><fmt:formatDate value="${economic.time}" type="both" pattern="yyyy.MM.dd HH:mm:ss"/></td></tr>
        	<tr><td>会议主题</td><td>${economic.topic}</td></tr>
        	<tr><td>关联个股</td><td>${economic.stockName}</td></tr>
        	<tr><td>会议分类</td>
	        	<td>
	        	<s:if test="%{economic.meetingType == 1}">经济会议</s:if>
				<s:elseif test="%{economic.meetingType == 2}">政治会议</s:elseif>
				<s:elseif test="%{economic.meetingType == 3}">其他会议</s:elseif>
			</td></tr>
        	<tr><td>国内/国际</td><td><s:if test="%{economic.isInland == 1}">国际</s:if>
			<s:elseif test="%{economic.isInland == 2}">国内</s:elseif></td></tr>
        	<tr><td>影响类别</td><td><s:if test="%{economic.impactType == 1}">利空</s:if>
			<s:elseif test="%{economic.impactType == 2}">利好</s:elseif>
			<s:elseif test="%{economic.impactType == 3}">中性</s:elseif></td></tr>
        	<tr><td>影响时限</td><td>${economic.impactLimit}</td></tr>
        	<tr><td>备注</td><td>${economic.remark}</td></tr>
        </table>
        </div>
        <div data-role="footer" data-theme="b" data-position="fixed">
            <h1>&copy; 2013 - 内参系统</h1>
        </div>
    </div>
</body>
</html>
