<%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/19
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="captcha" value="${false}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-登录</title>
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
    <style type="text/css">
        #captcha
        {

        }
    </style>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<c:if test="${param.msg eq 'error'}">
    <span style="color: red">用户名或密码错误</span>
</c:if>
<c:if test="${param.msg eq 'success'}">
    <span style="color: #00a73e">注册成功，请登录</span>
</c:if>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/riderCenter/login" method="post" enctype="multipart/form-data">
        <table class="login">
            <tr>
                <td width="40%" align="right" class="FontW">用户名：</td>
                <td><input type="text" name="username" id="username" required autofocus placeholder="账号/电子邮件/手机号码"></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">密码：</td>
                <td><input type="password" name="password" id="password" required></td>
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
                <td><input type="submit" name="btn" id="btn" value="登 录" class="Submit_b" onclick="alertVerify()" >( 还没注册骑手？，<a href="${path}/riderCenter/register" class="BlueA">请注册</a> )</td>
            </tr>
        </table>
    </form>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/riderFoot.jsp"></jsp:include>
</body>
</html>
<style>
    .sliderContainer{
        height: 40px !important;
    }
</style>
<script type="text/javascript">
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