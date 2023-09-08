<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="captcha" value="${false}"></c:set>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-注册</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发"/>
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!"/>
    <meta name="author" content="DeathGhost"/>
    <link rel="stylesheet" href="${path}/webConfig/style/slidercaptcha.css" type="text/css"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css"/>
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
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/riderCenter/register" method="post" enctype="multipart/form-data">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">用户名：</td>
                <td><input type="text" name="username" id="username" required autofocus><span id="usernameMsg"></span>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">密码：</td>
                <td><input type="password" name="password" id="password" required><span id="passwordMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">再次确认：</td>
                <td><input type="password" name="confirmPassword" id="confirmPassword" required><span
                        id="confirmPasswordMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">骑手姓名：</td>
                <td><input type="text" name="name" id="name" required><span id="nameMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">手机号码：</td>
                <td><input type="text" name="phone" id="phone" required><span id="phoneMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">身份证号：</td>
                <td><input type="text" name="identification" id="identification" required
                           pattern="[1-9]\d{5}(19|20|21)\d{2}((0[1-9])|1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]"><span
                        id="identificationMsg"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">选择送货范围：</td>
                <td>
                    <select name="province.id" id="province" class="select_ssq">
                        <c:forEach items="${requestScope.sysAreaList}" var="sa">
                            <option value="${sa.id}"}>${sa.name}</option>
                        </c:forEach>
                    </select>
                    <select name="city.id" id="city" class="select_ssq"></select>
                    <select name="district.id" id="district" class="select_ssq"></select>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">验证码：</td>
                <td><input type="button" name="verify" id="verify" value="点击验证" class="Submit_b"
                           onclick="setCaptcher()"></td>
            </tr>
            <tr id="captcharow" style="display: none;height: 200px;">
                <td width="40%" align="right" class="FontW"></td>
                <td>
                    <div id="captcha" hidden></div>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" id="btn" name="" class="Submit_b" value="注 册" onclick="alertVerify()">(
                    已经是骑手？<a href="${path}/riderCenter/login" class="BlueA">请登录</a> )
                </td>
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
    .sliderContainer {
        height: 40px !important;
    }
</style>
<script type="text/javascript">
    var usernameFlag = false, passwordFlag = false, confirmPasswordFlag = false, nameFlag = false, phoneFlag = false,
        identificationFlag = false;

    function checkUsername() {
        var username = $("#username").val();
        var usernameExp = /^\w{5,20}$/;
        if (!usernameExp.test(username)) {
            $("#usernameMsg").html("用户名格式错误，请输入5-20为字母数字下划线");
            $("#usernameMsg").css("color", "red");
            usernameFlag = false;
        } else {
            $.ajax({
                url: "${path}/riderCenter/existRider",
                data: {username: username},
                success: function (data) {
                    console.log("-----------------")
                    console.log(data);
                    if (data == "ok") {
                        $("#usernameMsg").html("√");
                        $("#usernameMsg").css("color", "green");
                        usernameFlag = true;
                    } else if (data == "no") {
                        $("#usernameMsg").html("用户名已存在");
                        $("#usernameMsg").css("color", "red");
                        usernameFlag = false;
                    }
                }
            });
        }
    }

    function checkPassword() {
        var password = $("#password").val();
        var passwordExp = /^.{5,20}$/;
        if (!passwordExp.test(password)) {
            $("#passwordMsg").html("密码格式错误，请输入5到20位的任意字符");
            $("#passwordMsg").css("color", "red");
            passwordFlag = false;
        } else {
            $("#passwordMsg").html("√");
            $("#passwordMsg").css("color", "green");
            passwordFlag = true;
        }
    }

    function checkConfirmPassword() {
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();
        if (password != confirmPassword) {
            $("#confirmPasswordMsg").html("两次密码输入不一致");
            $("#confirmPasswordMsg").css("color", "red");
            confirmPasswordFlag = false;
        } else {
            $("#confirmPasswordMsg").html("√");
            $("#confirmPasswordMsg").css("color", "green");
            confirmPasswordFlag = true;
        }
    }

    function checkName() {
        var name = $("#name").val();
        var nameExp = /^[\u4e00-\u9fa5a-zA-Z0-9]{1,6}$/;
        if (!nameExp.test(name)) {
            $("#nameMsg").html("姓名不符合规定，请输入合法的姓名");
            $("#nameMsg").css("color", "red");
            nameFlag = false;
        } else {
            $("#nameMsg").html("√");
            $("#nameMsg").css("color", "green");
            nameFlag = true;
        }
    }

    function checkPhone() {
        var phone = $("#phone").val();
        var phoneExp = /^1[3-9]\d{9}$/;
        if (!phoneExp.test(phone)) {
            $("#phoneMsg").html("手机号码不符合规定，请输入合法的手机号");
            $("#phoneMsg").css("color", "red");
            phoneFlag = false;
        } else {
            $("#phoneMsg").html("√");
            $("#phoneMsg").css("color", "green");
            phoneFlag = true;
        }
    }

    function checkIdentification() {
        var identification = $("#identification").val();
        var identificationExp = /^[1-9]\d{5}(19|20|21)\d{2}((0[1-9])|1[0-2])(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
        if (!identificationExp.test(identification)) {
            $("#identificationMsg").html("身份证号码不符合规定，请输入合法的身份证号");
            $("#identificationMsg").css("color", "red");
            identificationFlag = false;
        } else {
            $("#identificationMsg").html("√");
            $("#identificationMsg").css("color", "green");
            identificationFlag = true;
        }
    }

    function getDistrict() {
        $("#district").empty();
        var id = $("#city").val();
        $.get("${path}/riderCenter/address/getSysArea", {id: id}, function (data) {
            for (var i = 0; i < data.length; i++) {
                var option = $("<option>");
                option.val(data[i].id);
                option.html(data[i].name);

                $("#district").append(option);
            }
        });
    }

    function getCity() {
        $("#city").empty();
        var id = $("#province").val();
        $.get("${path}/riderCenter/address/getSysArea", {id: id}, function (data) {
            console.log(data);
            for (var i = 0; i < data.length; i++) {
                var option = $("<option>");
                option.val(data[i].id);
                option.html(data[i].name);

                $("#city").append(option);
            }
            getDistrict();
        });
    }

    $(function () {
        $("#username").blur(checkUsername);
        $("#password").blur(checkPassword);
        $("#confirmPassword").blur(checkConfirmPassword);
        $("#name").blur(checkName);
        $("#phone").blur(checkPhone);
        $("#identification").blur(checkIdentification);
        $("#province").change(getCity);
        $("#city").change(getDistrict);
        getCity();

        $("#btn").click(function () {
            checkUsername();
            checkPassword();
            checkConfirmPassword();
            checkName();
            checkPhone();
            checkIdentification();
            if (!usernameFlag || !passwordFlag || !confirmPasswordFlag || !nameFlag || !phoneFlag || !identificationFlag) {
                //阻止表单提交
                return false;
            }
        });
    });

    var flag = false;

    function setCaptcher() {
        var captchaRow = document.getElementById("captcharow");
        captchaRow.style.display = "";
        var captchaDiv = document.getElementById("captcha");
        captchaDiv.style.display = "block";
        captchaDiv.style.margin = "0";
    }

    function alertVerify() {
        if (flag == false) {
            var btn = document.getElementById("btn");
            btn.setAttribute("disabled", "disabled");
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
            setTimeout(function () {
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