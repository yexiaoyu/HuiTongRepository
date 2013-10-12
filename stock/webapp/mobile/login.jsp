<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/resources/jsp/taglibs.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="jscss/jquery-mobile/jquery.mobile-1.0a3.min.css" rel="stylesheet" type="text/css"/>
<script src="jscss/jquery-mobile/jquery-1.5.min.js" type="text/javascript"></script>
<script src="jscss/jquery-mobile/jquery.mobile-1.0a3.min.js" type="text/javascript"></script>
<script src="jscss/phonegap.js" type="text/javascript"></script>
<script type="text/javascript">
     jQuery(document).ready(function() {
    	//输入事件
        $("input[id]").bind("focus",function () {
        if($(this).attr("id")=='username'||$(this).attr("id")=='password')
        	$(this).attr("value","");
        });
      	//提交
        $("#submit").bind("click", function() {
              if (valid()) {
                $.ajax({
                   type: "POST",
                   url: rootPath + "/mobile/login",
                   data: $("form#loginform").serialize(),
                   success: function(msg){
                    alert("sucess=" + msg);
                     /*if(msg=='success'){
                        $.mobile.changePage("index.jsp","slidedown", true, true);
                     }else{
                        $.mobile.changePage("index.jsp","slidedown", true, true);
                     }*/
                   }
                });
              }
            });
        });
   		//输入信息验证
        function valid(){
            if($("#username").attr("value")==''||$("#password").attr("value")==''){
                $.mobile.changePage("content/loginfalse.html","slidedown", true, true);
                return false;          
            }
            return true;
        };
        $('.dtload').live('click',function(){
            var shtml='<a href="#" data-role="button">基于链接的按钮</a>    <a href="#" data-role="button">基于链接的按钮[块级元素]</a>'
            $(this).html(shtml);
            //以上代码只是把结构加上去了，但是却没有加上jqm的样式，
            $(this).trigger('create');//加上这句就可以加上jqm的样式【即使用jqm的渲染】
        })
    </script>
<style type="text/css">
p{font-size: 1.5em;font-weight: bold;}
#submit{float:right; margin:10px;}
#toregist{float:left; margin:10px;}
</style>
</head> 
<body> 
<!-- begin first page -->
<div id="page1" data-role="page">
  <div data-role="header" data-position="fixed" data-theme="b">
      <h1>登录内参系统</h1>
   </div>
  <div data-role="content" class="content">
    <p style="backg"><font color="#2EB1E8" >内参系统</font></p>
        <form method="post" id="loginform" action="${ctx }/mobile/login">
            <input type="text" name="j_username" id="username" value="用户名"/><br>
            <input type="password" name="j_password" id="password" value="密码输入提示"/>
                    <fieldset data-role="controlgroup" >
                        <input type="checkbox" name="checkbox-1" id="checkbox-1" class="custom" />
                        <label for="checkbox-1">保持登录状态</label>
                    </fieldset>
            <a href="content/regist.html" data-role="button" id="toregist" data-theme="e">注册</a>
           <a data-role="button" id="submit" data-theme="b">登录</a> 
          <!--   <input type="submit" value="登录" data-role="button" data-theme="b" id="submit"/>-->
        </form>
  </div>
  <div class="dtload">动态载入</div>
  <div data-role="footer" data-position="fixed" data-theme="b"><h1>©2013 股票内参系统</h1></div>
</div>
<!-- end first page -->

</body>
</html>

