<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<%@page import="cn.com.huitong.model.AppUser"%>
<%@page import="cn.com.huitong.util.ContextUtil"%>
<%
  	AppUser currentUser=ContextUtil.getCurrentUser();
  	request.setAttribute("currentUser", currentUser);
%>
<html>
<head>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="logo">内参系统</div>
	<div class="logoRight">
	<div class="onlineSum">在线人数:200</div>
	<div class="link">
	<c:choose>
  		<c:when test="${currentUser == null }">
  				<a href='#' target="_parent">请登录</a>|<a href='#' target="_parent">注册新用户</a>
  		</c:when>
	  	<c:otherwise>
	  	   欢迎您！${currentUser.userName }<a href='${ctx }/logout' target="_parent">退出系统</a>
	  	</c:otherwise>
  </c:choose>
	<%-- <s:if test="%{currentUser == null }">
		<a href='#' target="_parent">请登录</a>|<a href='#' target="_parent">注册新用户</a>
	</s:if>
	<s:else>
		欢迎您！${currentUser.userName }<a href='${ctx }/logout' target="_parent">退出系统</a>
	</s:else>--%>
	|<a href="#" target="_parent">帮助</a></div>
	</div>
</body>
</html>