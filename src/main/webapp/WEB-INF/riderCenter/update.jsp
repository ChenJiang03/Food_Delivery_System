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
            <form action="${path}/riderCenter/update" method="post" id="myform" name="myform" enctype="multipart/form-data">
                <table>
                    <tr>
                        <td width="30%" align="right">修改头像：</td>
                        <td>
                            <div id="pimg">
                                <input type="hidden" value="${rider.picture}" name="picture" id="picture">
                                <img src="${path}${rider.picture}" style="width: 100px;height: 100px;display: ${empty user.picture?'none':''}" id="img">
                            </div>
                            <input type="file" id="file" name="file">
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">用户名：</td>
                        <td><input type="text" name="username" readonly id="username" value="${rider.username}"><span id="usernameMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">修改手机号：</td>
                        <td><input type="text" name="phone" id="phone" value="${rider.phone}"><span id="phoneMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">修改名字：</td>
                        <td><input type="text" name="name" id="name" value="${rider.name}"><span id="nameMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">是否可以工作：</td>
                        <td>
                            <input type="radio" name="available" value="0" ${rider.available?"":"checked"} >否 <input type="radio" name="available" value="1" ${rider.available?"checked":""}>是
                        </td>
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
    var usernameFlag=false,nameFlag=false,phoneFlag=false;
    $(function (){
        $("#username").blur(checkUsername);
        $("#name").blur(checkName);
        $("#phone").blur(checkPhone);

        $("#btn").click(function (){
            checkUsername();
            // checkPassword();
            checkName();
            checkPhone();
            if(!usernameFlag||!nameFlag||!phoneFlag){
                console.log(usernameFlag);
                console.log(nameFlag);
                console.log(phoneFlag);
                console.log(1);
                //阻止表单提交
                return false;
            }
        });

        $("#file").change(function (){
            var formData = new FormData($("#myform")[0]);
            formData.append("file",$("#file")[0]);
            $.ajax({
                url: "${path}/riderCenter/uploadPic",
                type:"post",
                data:formData,
                contentType:false,
                processData:false,
                success:function (data){
                    if(data=="fail"){
                        alert("请选择图片");
                        return;
                    }
                    $("#img").attr("src","${path}"+data);
                    $("#picture").val(data);
                }


            });

        });
    });

    function checkUsername()
    {
        var username = $("#username").val();
        var usernameExp = /^\w{5,20}$/;
        if (!usernameExp.test(username))
        {
            $("#usernameMsg").html("用户名格式错误，请输入5-20为字母数字下划线");
            $("#usernameMsg").css("color","red");
            usernameFlag=false;
        }
        else
        {
            if (username == "${rider.username}")
            {
                $("#usernameMsg").html("√");
                $("#usernameMsg").css("color","green");
                usernameFlag=true;
            }
            else
            {
                $.ajax({
                    url:"${path}/riderCenter/existRider",
                    data:{username:username},
                    success:function (data)
                    {
                        console.log("-----------------")
                        console.log(data);
                        if (data=="ok")
                        {
                            $("#usernameMsg").html("√");
                            $("#usernameMsg").css("color","green");
                            usernameFlag=true;
                        }
                        else if (data=="no")
                        {
                            $("#usernameMsg").html("用户名已存在");
                            $("#usernameMsg").css("color","red");
                            usernameFlag=false;
                        }
                    }
                });
            }
        }
    }
    // function checkPassword(){
    //     var password=$("#password").val();
    //     var passwordExp=/^.{5,20}$/;
    //     if(!passwordExp.test(password)){
    //         $("#passwordMsg").html("密码格式错误，请输入5到20位的任意字符");
    //         $("#passwordMsg").css("color","red");
    //         passwordFlag=false;
    //     }
    //     else{
    //         $("#passwordMsg").html("√");
    //         $("#passwordMsg").css("color","green");
    //         passwordFlag=true;
    //         console.log(passwordFlag);
    //     }
    // }
    function checkName(){
        var name=$("#name").val();
        var nameExp = /^[\u4e00-\u9fa5a-zA-Z0-9]{1,6}$/;
        if(!nameExp.test(name)){
            $("#nameMsg").html("姓名不符合规定，请输入合法的姓名");
            $("#nameMsg").css("color","red");
            nameFlag=false;
        }
        else{
            $("#nameMsg").html("√");
            $("#nameMsg").css("color","green");
            nameFlag=true;
        }
    }
    function checkPhone(){
        var phone=$("#phone").val();
        var phoneExp = /^1[3-9]\d{9}$/;
        if(!phoneExp.test(phone)){
            $("#phoneMsg").html("手机号码不符合规定，请输入合法的手机号");
            $("#phoneMsg").css("color","red");
            phoneFlag=false;
        }
        else{
            $("#phoneMsg").html("√");
            $("#phoneMsg").css("color","green");
            phoneFlag=true;
        }
    }
</script>