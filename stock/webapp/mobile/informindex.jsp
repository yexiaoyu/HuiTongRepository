<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/resources/jsp/taglibs.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta charset="utf-8">
<title>内参首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="jscss/jquery-mobile/jquery.mobile-1.3.1.css" rel="stylesheet" type="text/css"/>
<script src="jscss/jquery-mobile/jquery-1.8.2.js" type="text/javascript"></script>
<script src="jscss/jquery-mobile/jquery.mobile-1.3.1.js" type="text/javascript"></script>
</head> 
<body> 
<div data-role="page">
        <div data-role="header" data-position="fixed">
            <h1>内参系统</h1>
        </div>
        <div data-role="content">
            <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="b">
            	<s:iterator value="%{informList }" status="status">
	                <%--<li data-role="list-divider">
	                    <a href="buttons.html"><s:property value="title"/></a>
	                </li> --%>
	                <div data-role="collapsible" data-theme="b" data-content-theme="e" data-collapsed="true">
						<h3><s:property value="title"/></h3>
						<p><s:property value="content"/></p>
					</div>
            	</s:iterator>
            </ul>
        </div>
        <div data-role="footer" data-theme="b" data-position="fixed">
            <h1>&copy; 2013 - 内参系统</h1>
        </div>
    </div>
</body>
</html>
