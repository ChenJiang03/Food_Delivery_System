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
            <div class="crumb-list"><i class="icon-font"></i><a href="${path}/manage/manager/index">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="${path}/manage/product?action=list">产品管理</a><span class="crumb-step">&gt;</span><span>新增产品</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
                <form action="${path}/manage/user/add" method="post" id="myform" name="myform">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                            <th><i class="require-red">*</i>用户名:</th>
                            <td>
                                <input class="common-text required" id="username" name="username" size="50" value="" type="text">
                                <span id="usernameMsg"></span>
                            </td>

                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>密码:</th>
                            <td>
                                <input class="common-text required" id="password" name="password" size="50" value="" type="text">
                                <span id="passwordMsg"></span>
                            </td>

                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>姓名:</th>
                            <td>
                                <input class="common-text required" id="name" name="name" size="50" value="" type="text">
                                <span id="nameMsg"></span>
                            </td>

                        </tr>

                        <tr>
                            <th> 地址:</th>
                            <td><textarea name="address" class="common-textarea" id="address" cols="25" style="width: 80%;" rows="5"></textarea></td>
                        </tr>
                        <tr>
                            <th><i class="require-red">*</i>联系方式:</th>
                            <td>
                                <input class="common-text required" id="phone" name="phone" size="50" value="" type="text">
                                <span id="phoneMsg"></span>
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
<script>
    var flag =true
    $(function (){
        $("#username").blur(function (){
            checkUserName()

        })
        $("#password").blur(function (){
            checkPassword()

        })
        $("#name").blur(function (){
            checkName()

        })
        $("#phone").blur(function (){
            checkPhone()
        })

        $("#btn").click(function (){
            console.log(flag)
            if (!flag){
                return false;
            }

        })
    })
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
            flag=true;
        }
    }

    function checkPhone(){
        var phone = $("#phone").val();
        var phoneExp = /^[0-9]{11}$/;
        if(!phoneExp.test(phone)){
            $("#phoneMsg").html("输入格式错误");
            $("#phoneMsg").css("color","red");
            flag = false;
        }
        else{
            $("#phoneMsg").html("√");
            $("#phoneMsg").css("color","green");
            flag=true;
        }
    }

    function checkUserName(){
        var username = $("#username").val();
        var usernameExp = /^\w{5,15}$/;
        $.ajax({
            url:"${path}/manage/user/existUser",
            type:"post",
            data:{username:username},
            success:function (data) {
                if(data=="yes"){
                    $("#usernameMsg").html("用户名已存在！");
                    $("#usernameMsg").css("color","red");
                    flag = false;
                }else if(data=="no"){
                    if(!usernameExp.test(username)){
                        $("#usernameMsg").html("用户名格式错误");
                        $("#usernameMsg").css("color","red");
                        flag = false;
                    }
                    else{
                        $("#usernameMsg").html("√");
                        $("#usernameMsg").css("color","green");
                        flag=true;
                    }
                }

            }
        })
    }

    function checkName(){
        var name = $("#name").val();
        var nameExp =/^[\u4e00-\u9fa5]{2,7}$/;
        if(!nameExp.test(name)){
            $("#nameMsg").html("姓名格式错误");
            $("#nameMsg").css("color","red");
            flag = false;
        }else{
            $("#nameMsg").html("√");
            $("#nameMsg").css("color","green");
            flag=true;
        }

    }




</script>

