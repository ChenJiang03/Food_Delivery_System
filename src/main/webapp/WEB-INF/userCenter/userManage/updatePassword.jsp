<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/6/24
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>更改密码</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <!--
    Author: DeathGhost
    Author URI: http://www.deathghost.cn
    -->
</head>
<body>
<jsp:include page="/webConfig/inc/userTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/userLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Account-->
        <section class="AccManage Overflow">
            <span class="AMTitle Block Font14 FontW Lineheight35">账户管理</span>
            <p><a href="#" target="_blank">修改您的密码</a></p>
            <form action="${path}/userCenter/userManage/updatePassword" method="post">
                <input type="hidden" name="id" value="${sessionScope.user.id}">
                <table>

                    <tr>
                        <td width="30%" align="right">*旧密码：</td>
                        <td><input type="password" name="oldPassword" value="" id="oldPassword"><span id="oldMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*新密码：</td>
                        <td><input type="password" name="newPassword" value="" id="newPassword"><span id="newMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*确认密码：</td>
                        <td><input type="password" name="confirmPassword" value="" id="confirmPassword"><span id="confirmMsg"></span></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td><input name="" type="submit" value="保 存"></td>
                    </tr>
                </table>
            </form>
        </section>
    </article>
</section>
<!--End content-->
<div class="F-link">
    <span>友情链接：</span>
</div>
<jsp:include page="/webConfig/inc/userFoot.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    var flag = true;
    function  checkOldPasswd(){
        var oldPassword = $("#oldPassword").val();
        if(oldPassword == ${sessionScope.user.password}){
            $("#oldMsg").html("√");
            $("#oldMsg").css("color","green");
        }
        else{
            $("#oldMsg").html("旧密码错误");
            $("#oldMsg").css("color","red");
            flag = false;
        }
    }

    function newPassword(){
        var password = $("#newPassword").val();
        var passwordExp = /^[\w\W]{10,20}$/;
        if(!passwordExp.test(password)){
            $("#newMsg").html("密码格式错误");
            $("#newMsg").css("color","red");
            flag = false;
        }
        else{
            $("#newMsg").html("√");
            $("#newMsg").css("color","green");
        }
    }

    function checkPasswd(){
        var password=$("#newPassword").val();
        var confirmPassword=$("#confirmPassword").val();
        if(password!=confirmPassword){
            $("#confirmMsg").html("两次密码输入不一致");
            $("#confirmMsg").css("color","red");
            flag=false;
        }
        else{
            $("#confirmMsg").html("√");
            $("#confirmMsg").css("color","green");
        }
    }

    $(function (){
        $("#oldPassword").blur(checkOldPasswd);
        $("#newPassword").blur(newPassword);
        $("#confirmPassword").blur(checkPasswd);
        $("#btn").click(function (){
            checkOldPasswd();
            newPassword();
            checkPasswd();
            if(!flag){
                return false;
            }
        })

    });
</script>
