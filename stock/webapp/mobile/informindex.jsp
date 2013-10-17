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
<style type="text/css">
#submit{float:right; margin:10px;}
#toregist{float:left; margin:10px;}
</style>
</head> 
<body> 
<div data-role="page">
        <div data-role="header" data-position="fixed" >
        	<div class="ui-grid-b">
	        	<div class="ui-block-a" style="text-align: center;">
			    <div class="ui-bar ui-bar-b" data-role="button">注册用户</div>
			     </div>
			     <div class="ui-block-b" style="text-align: center;">
			    <div class="ui-bar ui-bar-b" data-role="button">普通会员</div>
			     </div>
			     <div class="ui-block-c" style="text-align: center;">
			    <div class="ui-bar ui-bar-b" data-role="button">高级VIP</div>
			     </div>
        	</div>
        </div>
        <div data-role="content">
        	<div class="notice"><span>温馨提示:</span><span style="color: red">每交易日早上9点更新，请注意查看。</span></div>
			<div data-role="collapsible-set" data-theme="e" data-content-theme="d">
            	<s:iterator value="%{informList }" status="status">
				    <div data-role="collapsible">
				        <h3><s:property value="title"/></h3>
				        <p><s:property value="content"/></p>
				    </div>
			    </s:iterator>
			</div>
        </div>
        <div data-role="footer" data-theme="b" data-position="fixed">
            <h1>&copy; 2013 - 内参系统</h1>
        </div>
    </div>
</body>
</html>
