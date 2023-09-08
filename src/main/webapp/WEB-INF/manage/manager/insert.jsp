<%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/18
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加产品</title>
</head>
<body>
<jsp:include page="/manageConfig/inc/top.jsp"></jsp:include>
<div class="container clearfix">
    <jsp:include page="/manageConfig/inc/left.jsp"></jsp:include>
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/product?action=list">产品管理</a><span class="crumb-step">&gt;</span><span>新增产品</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
                <form action="${path}/manage/manager/insert" method="post" id="myform" name="myform">
                    <table class="insert-tab" width="100%">
                        <tbody>


                        <tr>
                            <th><i class="require-red">*</i>用户名：</th>
                            <td>
                                <input class="common-text required" id="username" name="username" size="50" value="" type="text" placeholder="5-15位大小写字母及数字"><span id="usernameMsg"></span>
                            </td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>密码：</th>
                            <td>
                                <input class="common-text required" id="password" name="password" size="50" value="" type="text" placeholder="10-20任意字符"><span id="passwordMsg"></span>
                            </td>
                        </tr>

                        <tr>
                            <th></th>
                            <td>
                                <input class="btn btn-primary btn6 mr10" value="提交" type="submit" id="btn">
                                <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                            </td>
                        </tr>
                        </tbody></table>
                </form>
            </div>
        </div>

    </div>
    <!--/main-->
</div>
</body>
</html>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    flag = true;
    $(function () {
        $("#username").blur(checkName);
        $("#password").blur(checkPassword);
        $("#btn").click(function () {
            checkName();
            checkPassword();
            if (!flag) {
                //阻止表单提交
                return false;
            }
        });
    })

    function checkName(){
        var username = $("#username").val();
        var usernameExp = /^\w{5,15}$/;
        if(!usernameExp.test(username)){
            $("#usernameMsg").html("用户名格式错误");
            $("#usernameMsg").css("color","red");
            flag = false;
        }
        else{
            $.ajax({
                url:"${path}/manage/manager/exist",
                type:"post",
                data:"username="+username,
                success:function(data){
                    if(data=="ok"){
                        $("#usernameMsg").html("√");
                        $("#usernameMsg").css("color","green");
                    }
                    else if(data=="no"){
                        $("#usernameMsg").html("用户名已存在");
                        $("#usernameMsg").css("color","red");
                        flag=false;
                    }
                }

            });
        }
    }

    function checkPassword(){
        var password = $("#password").val();
        var passwordExp = /^[\w\W]{10,20}$/;
        if(!passwordExp.test(password)){
            $("#passwordMsg").html("密码格式错误");
            $("#passwordMsg").css("color","red");
            flag = false;
        }
        else{
            $("#passwordMsg").html("√");
            $("#passwordMsg").css("color","green");
        }
    }

</script>

