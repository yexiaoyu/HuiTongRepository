<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
</script>
<div class="loginForm">
	<%@ include file="/pages/background//stock/queryStockForm.jsp"%>
	<div style="height: 30px;background-color: red;font-size: 1.5em;line-height: 100%;">查询结果</div>
	<div id="displyResult">
	<%@ include file="/pages/background/stock/queryStockResult.jsp"%>
	</div>
</div>