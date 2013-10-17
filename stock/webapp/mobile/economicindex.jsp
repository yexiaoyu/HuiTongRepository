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
        	<h1>财经日历</h1>
        </div>
        <div data-role="content">
        	<ol data-role="listview" data-theme="c">
        		<s:iterator value="%{economicList }" status="status">
				    <li><a href="${ctx }/mobile/economicDetail.do?economicId=${economicID }">会议主题：<s:property value="topic"/></a></li>
			    </s:iterator>
			</ol>
        </div>
        <div data-role="footer" data-theme="b" data-position="fixed">
            <h1>&copy; 2013 - 内参系统</h1>
        </div>
    </div>
</body>
</html>
