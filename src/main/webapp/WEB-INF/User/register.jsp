<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/6/19
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="captcha" value="${false}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-注册</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" href="${path}/webConfig/style/slidercaptcha.css" type="text/css"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/longbow.slidercaptcha.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/User/register" method="post" enctype="multipart/form-data">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">用户名：</td>
                <td><input type="text" name="username" required autofocus id="username"><span id="usernameMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">密码：</td>
                <td><input type="password" name="password" required id="password"><span id="passwordMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">再次确认：</td>
                <td><input type="password" name="" required id="confirmPassword"><span id="confirmPasswordMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">真实姓名：</td>
                <td><input type="text" name="name" required id="name"><span id="nameMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">收货地址：</td>
                <td><input type="text" name="address" required></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">手机号码：</td>
                <td><input type="text" name="phone" required id="phone"><span id="phoneMsg"></span></td>
            </tr>

            <tr>
                <td width="40%" align="right" class="FontW">出生日期：</td>
                <td><input type="date" name="birthday"></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">验证码：</td>
                <td><input type="button" name="verify" id="verify" value="点击验证" class="Submit_b" onclick="setCaptcher()"></td>
            </tr>
            <tr id="captcharow" style="display: none;height: 200px;">
                <td width="40%" align="right" class="FontW"></td>
                <td>
                    <div id="captcha" hidden></div>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" name="" class="Submit_b" onclick="alertVerify()" value="注 册" id="btn"></td>
            </tr>
        </table>
    </form>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>
<style>
    .sliderContainer{
        height: 40px !important;
    }
</style>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script>
    var nameflag=true;
    var paswdflag=true;
    var realnameflag=true;
    var phoneflag=true;
    var confirmflag=true;
    var codeflag=true;
    $(function (){
        $("#username").blur(checkName);
        $("#password").blur(checkPassword);
        $("#confirmPassword").blur(confirmPassword);
        $("#phone").blur(checkPhone);
        $("#name").blur(checkrealName);
        $("#code").blur(function (){
            var code=$(this).val();
            $.ajax({
                url:"${path}/Code/checkCode",
                type:"post",
                data:{code:code},
                success:function (data) {
                    if (data == "ok") {
                        $("#codeMsg").html("√");
                        $("#codeMsg").css("color", "green");
                        codeflag=true;
                    } else {
                        $("#codeMsg").html("验证码错误");
                        $("#codeMsg").css("color", "red");
                        codeflag = false;
                    }
                }
            })

        })
        $("#btn").click(function (){
            checkName();
            checkPassword();
            confirmPassword();

            if(nameflag==false||paswdflag==false||phoneflag==false||codeflag==false||nameflag==false||realnameflag==false) {
                //阻止表单提交
                return false;
            }
        });



        $("#refersh").click(function (){
            $("#codeImg").attr("src","${path}/Code/getCode?random="+Math.random());
            return false;
        })




    })

    function checkPassword(){
        var password = $("#password").val();
        var passwordExp = /^[\w\W]{10,20}$/;
        if(!passwordExp.test(password)){
            $("#passwordMsg").html("密码格式错误");
            $("#passwordMsg").css("color","red");
            paswdflag = false;
        }
        else{
            $("#passwordMsg").html("√");
            $("#passwordMsg").css("color","green");
            paswdflag=true;
        }
    }

    function checkPhone(){
        var phone = $("#phone").val();
        var phoneExp = /^[0-9]{11}$/;
        if(!phoneExp.test(phone)){
            $("#phoneMsg").html("手机号格式错误");
            $("#phoneMsg").css("color","red");
            phoneflag = false;
        }
        else{
            $("#phoneMsg").html("√");
            $("#phoneMsg").css("color","green");
            phoneflag=true;
        }
    }

    function checkrealName(){
        var name = $("#name").val();
        var nameExp = /^[\u4e00-\u9fa5]{2,7}$/;
        if(!nameExp.test(name)){
            $("#nameMsg").html("密码格式错误");
            $("#nameMsg").css("color","red");
            realnameflag = false;
        }
        else{
            $("#nameMsg").html("√");
            $("#nameMsg").css("color","green");
            realnameflag=true;
        }
    }

    function checkName(){
        var username = $("#username").val();
        var usernameExp = /^\w{5,15}$/;
        if(!usernameExp.test(username)){
            $("#usernameMsg").html("用户名格式错误");
            $("#usernameMsg").css("color","red");
            nameflag = false;
        }
        else{
            $.ajax({
                url:"${path}/User/exist",
                type:"post",
                data:"username="+username,
                success:function(data){
                    if(data=="ok"){
                        $("#usernameMsg").html("√");
                        $("#usernameMsg").css("color","green");
                        nameflag=true;
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

    function confirmPassword(){
        var password=$("#password").val();
        var confirmPassword=$("#confirmPassword").val();
        if(password!=confirmPassword){
            $("#confirmPasswordMsg").html("两次密码输入不一致");
            $("#confirmPasswordMsg").css("color","red");
            flag=false;
        }
        else{
            $("#confirmPasswordMsg").html("√");
            $("#confirmPasswordMsg").css("color","green");
        }
    }

    var flag = false;
    function setCaptcher()
    {
        var captchaRow = document.getElementById("captcharow");
        captchaRow.style.display = "";
        var captchaDiv = document.getElementById("captcha");
        captchaDiv.style.display = "block";
        captchaDiv.style.margin = "0";
    }
    function alertVerify()
    {
        if (flag == false)
        {
            var btn = document.getElementById("btn");
            btn.setAttribute("disabled","disabled");
            alert("请先滑动验证码验证");
        }
    }

    sliderCaptcha({
        id: 'captcha',
        width: 280,
        height: 150,
        sliderL: 42,
        sliderR: 9,
        offset: 5,
        loadingText: '正在加载中...',
        failedText: '再试一次',
        barText: '向右滑动填充拼图',
        repeatIcon: 'fa fa-redo',
        setSrc: function () {
            return '${path}/webConfig/captchaImage/Pic' + Math.round(Math.random() * 10) + '.jpg';
        },
        <%--onFail: function ()--%>
        <%--{--%>
        <%--    ${captcha} = false;--%>
        <%--    console.log(${captcha});--%>
        <%--},--%>
        onSuccess: function () {
            ${captcha = true};
            flag = true;
            console.log(${captcha});
            var btn = document.getElementById("btn");
            btn.removeAttribute("disabled");
            setTimeout(function() {
                $("#captcharow").hide();
            }, 1000);

        },
        verify: function (arr, url) {
            console.log("-----------------")
            console.log(arr)
            var ret = false;
            $.ajax({
                url: url,
                data: JSON.stringify(arr),
                async: false,
                cache: false,
                type: 'POST',
                contentType: 'application/json',
                dataType: 'json',
                success: function (result) {
                    ret = result;
                }
            });
            return ret;
        },
        remoteUrl: "${path}/sliderCaptcha/isVerify"
    });
</script>