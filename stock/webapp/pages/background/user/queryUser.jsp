<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
</script>
<div class="loginForm">
	<%@ include file="/pages/background/user/queryUserForm.jsp"%>
	<div class="resultDiv">查询结果</div>
	<div id="displyResult">
	<%@ include file="/pages/background/user/queryUserResult.jsp"%>
	</div>
</div>
