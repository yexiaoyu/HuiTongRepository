<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<link href="${ctx }/resources/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
</script>
<div class="loginForm">
	<div class="listInfo">
	  <div class="qatt">内参详细信息</div>
	  <table class="qaTable">
		  <tr>
		    <th width="17%">用户级别</th>
		    <td width="17%">${information.grade.gradeName }</td>
		    <th width="17%">针对股票</th>
		    <td width="17%">${information.stock.stockCode }${information.stock.stockName }</td>
		    <th width="17%">是否有效</th>
		    <td width="17%">${information.isValid }</td>
		  </tr>
		  <tr>
		    <th>主题</th>
		    <td colspan="3">${information.title }</td>
		    <th>录入时间</th>
		    <td ><fmt:formatDate value="${information.inputTime}" type="both" pattern="yyyy.MM.dd HH:mm:ss"/></td>
		  </tr>
		  <tr>
		    <th>内容</th>
		    <td colspan="5">${information.content }</td>
		  </tr>
	  </table>
	</div>
</div>