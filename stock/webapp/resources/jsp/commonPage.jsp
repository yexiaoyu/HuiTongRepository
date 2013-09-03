<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<script type="text/javascript">
	$(function() {
		$("a[name='pageNo']").click(function() {
			$("#curpage").val($(this).attr("value"));
			queryPageList();
		});

		$("#queryPage").click(function() {
			if($("#myPage").val()>${pagingBean.pageCount}){
				alert("超过总页数，请重新输入！");
				return;
			}
			$("#curpage").val($("#myPage").val());
			queryPageList();
		});
	});
</script>

<input id="curpage" name="curpage" type="hidden" value="1">
每页显示 <input style="width: 20px" type="text" id="pagesize" name="pagesize" value="${pagingBean.pageSize}"/> 条记录 共 ${pagingBean.totalItems} 条记录 ${pagingBean.start}/${pagingBean.pageCount} 
<a href="#" name="pageNo" value="1">首页</a>
<c:if test="${pagingBean.start>1}">
	<a href="#" name="pageNo" value="${pagingBean.start-1}"><</a>
</c:if>
<a href="#" name="pageNo" value="1">1</a>
<c:if test="${pagingBean.pageCount!=1}">
	<c:choose>
		<c:when test="${pagingBean.start<=5}">
			<c:forEach var="i" begin="2" end="${pagingBean.start}">
				<a href="#" name="pageNo" value="${i}">${i }</a>
			</c:forEach>
		</c:when>
		<c:otherwise>    
            ...     
            <c:forEach var="i" begin="${pagingBean.start-3}" end="${pagingBean.start}">
				<a href="#" name="pageNo" value="${i}">${i }</a>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${pagingBean.start>=pagingBean.pageCount-4 || pagingBean.pageCount-4<=0}">
			<c:forEach var="i" begin="${pagingBean.start+1}" end="${pagingBean.pageCount}">
				<a href="#" name="pageNo" value="${i}">${i }</a>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach var="i" begin="${pagingBean.start+1}" end="${pagingBean.start+3}">
				<a href="#" name="pageNo" value="${i}">${i }</a>
			</c:forEach>    
            ...     
            <a href="#" name="pageNo" value="${pagingBean.pageCount}"> ${pagingBean.pageCount}</a>
		</c:otherwise>
	</c:choose>
</c:if>
<!-- 
href="value="${pageUrl}?page=${pagecount}"
 -->
<c:if test="${pagingBean.start<pagingBean.pageCount}">
	<a href="#" name="pageNo" value="${pagingBean.start+1}">></a>
</c:if>
<a href="#" name="pageNo" value="${pagingBean.pageCount}">尾页</a>
第<input type="text" id="myPage" name="myPage" size="4" value="${pagingBean.start }">页
<input id="queryPage" type="button" value="确定">
  共${pagingBean.pageCount} 页