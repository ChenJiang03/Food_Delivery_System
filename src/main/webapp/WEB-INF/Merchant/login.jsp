
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="captcha" value="${false}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>商家登录</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" href="${path}/webConfig/style/slidercaptcha.css" type="text/css"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/js/jquery-3.6.4.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/longbow.slidercaptcha.js"></script>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/Merchant/login" method="post">
        <table class="login">
            <tr>
                <td width="40%" align="right" class="FontW">账号：</td>
                <td><input type="text" name="username" required autofocus placeholder="账号/电子邮件/手机号码"></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">密码：</td>
                <td><input type="password" name="password" required></td>
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
                <td width="40%" align="right" class="FontW"><label for="rememberMe">记住账号：</label></td>
                <td><input type="checkbox" name="rememberMe" id="rememberMe"></td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" name="" id="tijiao" value="登 录" onclick="alertVerify()" class="Submit_b">( 已经是***会员，<a href="#" class="BlueA">请登录</a> )</td>
            </tr>
        </table>
    </form>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/merchantFoot.jsp"></jsp:include>
</body>
</html>
<style>
    .sliderContainer{
        height: 40px !important;
    }
</style>
<script>
    <%--$(function (){--%>
    <%--    var co=false;--%>

    <%--    $("#code").blur(function (){--%>
    <%--        var code=$(this).val();--%>
    <%--        $.ajax({--%>
    <%--            url:"${path}/Code/checkCode",--%>
    <%--            type:"post",--%>
    <%--            data:{code:code},--%>
    <%--            success:function (data) {--%>
    <%--                if(data=="ok"){--%>
    <%--                    $("#code1").html("√");--%>
    <%--                    co=true;--%>
    <%--                }--%>
    <%--                else{--%>
    <%--                    $("#code1").html("验证码错误");--%>
    <%--                    co=false;--%>
    <%--                }--%>
    <%--            }--%>
    <%--        })--%>
    <%--    });--%>

    <%--    $("#tijiao").click(function (){--%>
    <%--        if (co==false){--%>
    <%--            return false;--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>
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
            var btn = document.getElementById("tijiao");
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
            var btn = document.getElementById("tijiao");
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