<%@ page import="com.example.uglytuan.vo.Rider" %><%--
  Created by IntelliJ IDEA.
  User: Nancy
  Date: 2023/6/28
  Time: 22:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<c:set var="rider" value="${sessionScope.rider}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>DeathGhost-用户中心</title>
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
<jsp:include page="/webConfig/inc/riderTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <jsp:include page="/webConfig/inc/riderLeft.jsp"></jsp:include>
    <article class="U-article Overflow">
        <!--user Account-->
        <section class="AccManage Overflow">
            <span class="AMTitle Block Font14 FontW Lineheight35">账户管理</span>
            <form action="${path}/riderCenter/updatePass" method="post" id="myform" name="myform" enctype="multipart/form-data">
                <table>
                    <tr>
                        <td width="30%" align="right">请输入旧密码：</td>
                        <td><input type="password" name="oldPassword" id="oldPassword"><span id="oldPasswordMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">请输入新密码：</td>
                        <td><input type="password" name="newPassword" id="newPassword"><span id="newPasswordMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">请再次确认密码：</td>
                        <td><input type="password" name="confirmedPassword" id="confirmedPassword"><span id="confirmedPasswordMsg"></span></td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <input class="btn btn-primary btn6 mr10" id="btn" value="提交" type="submit">
                            <input class="btn btn6" onclick="history.go(-1)" value="返回" type="button">
                        </td>
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
<jsp:include page="/webConfig/inc/riderFoot.jsp"></jsp:include>
</body>
</html>
<script type="text/javascript" src="${path}/js/jquery-3.6.4.min.js" ></script>
<script type="text/javascript">
    var oldPasswordFlag=false, newPasswordFlag=false, confirmedPasswordFlag=false;
    $(function (){
        $("#oldPassword").blur(checkOldPassword);
        $("#newPassword").blur(checkNewPassword);
        $("#confirmedPassword").blur(checkConfirmedPassword);

        $("#btn").click(function (){
            checkOldPassword();
            checkNewPassword();
            checkConfirmedPassword();
            if(!oldPasswordFlag||!newPasswordFlag||!confirmedPasswordFlag){
                console.log(oldPasswordFlag);
                console.log(newPasswordFlag);
                console.log(confirmedPasswordFlag);
                console.log(1);
                //阻止表单提交
                return false;
            }
        });
    });

    function checkOldPassword()
    {
        var oldPassword = $("#oldPassword").val();

        $.ajax({
            url:"${path}/riderCenter/checkPassword",
            data:{oldPassword:oldPassword},
            success:function (data)
            {
                console.log("-----------------")
                console.log(data);
                if (data=="ok")
                {
                    $("#oldPasswordMsg").html("√");
                    $("#oldPasswordMsg").css("color","green");
                    oldPasswordFlag=true;
                }
                else if (data=="no")
                {
                    $("#oldPasswordMsg").html("旧密码错误");
                    $("#oldPasswordMsg").css("color","red");
                    oldPasswordFlag=false;
                }
            }
        });
    }
    function checkNewPassword(){
        var newPassword=$("#newPassword").val();
        var newPasswordExp=/^.{5,20}$/;
        if(!newPasswordExp.test(newPassword)){
            $("#newPasswordMsg").html("密码格式错误，请输入5到20位的任意字符");
            $("#newPasswordMsg").css("color","red");
            newPasswordFlag=false;
        }
        else{
            $("#newPasswordMsg").html("√");
            $("#newPasswordMsg").css("color","green");
            newPasswordFlag=true;
        }
    }
    function checkConfirmedPassword(){
        var newPassword=$("#newPassword").val();
        var confirmedPassword=$("#confirmedPassword").val();
        console.log(newPassword==confirmedPassword);
        if(newPassword != confirmedPassword){
            $("#confirmedPasswordMsg").html("两次密码输入不一样");
            $("#confirmedPasswordMsg").css("color","red");
            confirmedPasswordFlag=false;
        }
        else{
            $("#confirmedPasswordMsg").html("√");
            $("#confirmedPasswordMsg").css("color","green");
            confirmedPasswordFlag=true;
        }
    }
</script>