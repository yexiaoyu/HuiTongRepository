<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/resources/js/jquery-2.0.3.js"></script>
<title>股票内参系统</title>
</head>
<frameset rows="60px,*,60px" frameborder="no" border="0">
 	<frame src="${ctx }/resources/jsp/header.jsp" name="header" frameborder="1"/>
    <frameset cols="200px,*,200px" border="1" frameborder="no">
		<frame name="bodyleft" src="" noresize="yes" frameborder="1" scrolling="no" border="1px"/> 
		<frame name="bodycontent" src="${ctx }/resources/jsp/loginbody.jsp"/>  
		<frame name="bodyright" src="" frameborder="1"/>
    </frameset>
	<frame src="${ctx }/resources/jsp/footer.jsp" name="footer" frameborder="1" scrolling="no"/>
</frameset>
<noframes>
<body>您的浏览器无法处理框架！</body>
</noframes>
</html>


