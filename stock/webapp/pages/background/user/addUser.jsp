<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/resources/jsp/taglibs.jsp" %>
<link type="text/css" rel="stylesheet" href="${ctx }/resources/css/validator.css"></link>
<script type="text/javascript" src="${ctx }/resources/js/formValidator.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/formValidatorRegex.js"></script> 
<script type="text/javascript">
$(document).ready(function (){
	$.formValidator.initConfig({ formid: "addUserForm", onerror:function(msg){alert(msg);},onsuccess:function(){return true;} });
	$("#userName").formValidator({ onshow: "请输入用户名", onfocus: "用户名输入5-20个以字母开头、可带数字_.", oncorrect: "该用户名可以注册" })
		.inputValidator({min:5,max:20,onerror: "你输入的用户名非法,请确认"}).regexValidator({regexp:"^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$",onerror:"用户名格式不正确"})
		.ajaxValidator({
		    type : "get",
			url : rootPath + "/background/checkUserNameValid.do",
			addidvalue : true,
			datatype : "json",
			success : function(data){
	            if( data.pass == 1 ){
	                return true;
				}else{
	                return false;
				}
			},
			buttons: $("#formSubmit"),
			onerror : "该用户已注册，请重新输入",
			onwait : "正在校验验证码，请稍候..."
		});;
	$("#passWord").formValidator({ onshow: "请输入密码", onfocus: "输入5-20位密码", oncorrect: "输入正确" })
		.inputValidator({min:5,max:20,onerror: "请确认输入密码"});
	$("#passWord2").formValidator({ onshow: "请再次输入密码", onfocus: "再次输入密码", oncorrect: "输入正确" })
		.inputValidator({min:5,max:20,onerror: "请确认输入密码"}).functionValidator({
			fun:function(val,elem){
				var password = $("#passWord").val();
				if(val == password){
					return true;
				}else{
					return "两次密码输入不正确";
				}
			}
		});
	$("#gradeId").formValidator({ onshow: "请选择用户级别", onfocus: "请选择用户级别", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择用户级别"});
	$("#isValid").formValidator({ onshow: "请选择是否有效", onfocus: "请选择是否有效", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请选择是否有效"});
	$("#realName").formValidator({ onshow: "请输入姓名", onfocus: "输入2~5位姓名", oncorrect: "输入正确" })
		.inputValidator({min:2,max:5,onerror: "输入2~5位姓名"});
	$("#email").formValidator({ onshow: "请输入邮箱", onfocus: "请输入邮箱", oncorrect: "输入正确！" })
		.inputValidator({min:6,max:100,onerror:"你输入的邮箱长度非法,请确认"})
		.regexValidator({regexp:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$",onerror:"邮箱格式不正确"});
	$("#phone").formValidator({ onshow: "请输入手机号码", onfocus: "请输入手机号码", oncorrect: "输入正确！" })
		.inputValidator({min:11,max:11,onerror:"手机号码必须是11位的,请确认"})
		.regexValidator({regexp:"^0{0,1}(13[0-9]|145|147|15[0-3]|15[5-9]|18[0-9])[0-9]{8}$",onerror:"手机格式不正确"});
	$("#checkCode").formValidator({ onshow: "请输入验证码！", onfocus: "请输入验证码！", oncorrect: "输入正确" })
		.inputValidator({min:1,onerror: "请输入验证码！"}).ajaxValidator({
		    type : "get",
			url : rootPath + "/util/checkCodeValid.do",
			addidvalue : true,
			//data : "checkCode="+$("#checkCodeId").val(),
			datatype : "json",
			success : function(data){
	            if( data.pass == 1 ){
	                return true;
				}
	            else{
	            	alert("验证码输入错误！");
	                return false;
				}
			},
			buttons: $("#formSubmit"),
			onerror : "验证码输入错误！",
			onwait : "正在校验验证码，请稍候..."
		}); 
});
$("#formSubmit").click(function() {
	//验证通过提交数据
	if($.formValidator.pageIsValid('1')){
		var url = $("#addUserForm").attr("action");
		var data = $("#addUserForm").serialize();
		$.post(url, data, function(data) {
			$("#maincontent").html(data);
		});
	}
	//菜单显示切换
	$('#menu li').find(".light").removeClass("light");
	$('#queryUser').addClass("light");
	return false;
});
</script>
<div class="loginForm">
<div class="topbar">添加用户</div>
	<form action="operateUser.do" method="post" id="addUserForm" namespace="/background">
		<s:if test="%{nodeName == 'updateEntry' }">
			<s:hidden name="nodeName" value="update"/>
			<s:hidden name="user.userId"/>
		</s:if>
		<s:elseif test="%{nodeName == 'addEntry' }">
			<s:hidden name="nodeName" value="add"/>
			<s:hidden name="user.isValid" value="1"/>
		</s:elseif>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableLoginForm">
	    	<tr>
		    	<td class="t1">用户名</td>
		    	<s:if test="%{nodeName == 'updateEntry' }">
			    	<td class="t2"><s:hidden name="user.userName"/><s:property value="user.userName"/></td>
		    	</s:if>
		    	<s:elseif test="%{nodeName == 'addEntry' }">
		    		<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.userName" id="userName"/></td>
		    	</s:elseif>
		    	<td ><div id="userNameTip" style="width:300px"></div></td>
	    	</tr>
	    	<s:if test="%{nodeName == 'addEntry' }">
	    	<tr>
		    	<td class="t1">密码</td>
		    	<td class="t2"><s:password theme="simple" cssClass="textInput" name="user.passWord" id="passWord"/></td>
		    	<td ><div id="passWordTip" style="width:300px"></div></td>
	    	</tr>
	    	<tr>
		    	<td class="t1">确认密码</td>
		    	<td class="t2"><s:password theme="simple" cssClass="textInput" name="passWord2" id="passWord2"/></td>
		    	<td ><div id="passWord2Tip" style="width:300px"></div></td>
	    	</tr>
	    	</s:if>
	    	<tr>
				<td class="t1">用户级别</td>
				<td class="t2">
					<s:select theme="simple" cssClass="selectInput" name="user.grade.gradeId" 
						listValue="gradeName" listKey="gradeId" id="gradeId"
					 	list="gradeList" headerKey="" headerValue="请选择"></s:select>
				</td>
		    	<td ><div id="gradeIdTip" style="width:300px"></div></td>
			</tr>
			<tr>
		    	<td class="t1">真实姓名</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.realName" id="realName"/></td>
		    	<td ><div id="realNameTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">Email邮箱</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.email" id="email"/></td>
		    	<td ><div id="emailTip" style="width:300px"></div></td>
	    	</tr>
			<tr>
		    	<td class="t1">手机号码</td>
		    	<td class="t2"><s:textfield theme="simple" cssClass="textInput" name="user.phone" id="phone"/></td>
		    	<td ><div id="phoneTip" style="width:300px"></div></td>
	    	</tr>
	    	<s:if test="%{nodeName == 'updateUserEntry' }">
		    	<tr>
			    	<td class="t1">是否有效</td>
			    	<td class="t2"><s:select theme="simple" cssClass="selectInput" name="user.isValid" list="#{'0':'否','1':'是'}" id="isValid" headerKey="" headerValue="请选择"/></td>
			    	<td ><div id="isValidTip" style="width:300px"></div></td>
		    	</tr>
	    	</s:if>
	    	<tr>
				<td class="t1">验证码</td>
				<td class="t2"><input class="yzmInput" name="checkCode" id="checkCode" type="text" />
					<span id="codeImage"><img align="absmiddle" border="0" height="30px" width="70px" src="${ctx }/CaptchaImg?rand='<%=Math.random() %>'" />
					</span> <a href="javascript:refeshCode()">点击换图</a></td>
				<td><div id="checkCodeTip" style="width:300px"></div></td>
			</tr>
	    	<tr>
	    	<td>&nbsp;</td>
	    	<td><input class="button01" id="formSubmit" type="button" value="提交"/></td></tr>
    	</table>
	</form>
</div>
