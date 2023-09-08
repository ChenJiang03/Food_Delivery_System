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
    <title>更改信息</title>
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
            <p><a href="${path}/userCenter/userManage/updatePassword" target="_blank" >修改您的密码</a></p>
            <form action="${path}/userCenter/userManage/updateInfo" method="post" enctype="multipart/form-data" id="myform">
                <input type="hidden" name="id" value="${sessionScope.user.id}">
                <table>

                    <tr>
                        <td width="30%" align="right">*修改头像：</td>
                        <td>
                            <p id="pimg">
                            <input type="hidden" value="${sessionScope.user.picture}" name="picture" id="pic">
                            <img src="${path}${sessionScope.user.picture}" alt="" style="width: 100px;height: 100px;display: ${empty p.pic?'none':''}" id="img">
                        </p>
                            <input type="file" name="file" id="file"></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*昵称：</td>
                        <td><input type="text" name="username" readonly value="${sessionScope.user.username}" id="username"><span id="usernameMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*地址：</td>
                        <td><input type="text" name="address" value="${sessionScope.user.address}"></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*手机：</td>
                        <td><input type="text" name="phone" value="${sessionScope.user.phone}" id="phone"><span id="phoneMsg"></span></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*出生日期：</td>
                        <td><input type="date" name="birthday" value="${sessionScope.user.birthday}"></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">*真实姓名：</td>
                        <td><input type="text" name="name" value="${sessionScope.user.name}" id="name"><span id="nameMsg"></span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input name="" type="submit" value="保 存" id="submit"></td>
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
    var nameflag=true;
    var realnameflag=true;
    var phoneflag=true;
    $(function (){
        $("#file").change(function (){
            var formData = new FormData($("#myform")[0]);
            formData.append("file",$("#file")[0]);
            $.ajax({
                url:"${path}/userCenter/userManage/uploadPic",
                type:"post",  //上传图片必须用post请求
                data:formData,
                contentType:false,  //不让ajax修改的上传的方式
                processData:false,  //不让ajax处理上传的数据
                success:function (data){
                    if(data=="fail"){
                        alert("请上传一个图片");
                        return;
                    }
                    var img=$("<img>");
                    img.css({"width":"100px","height":"100px"});
                    $("#img").attr("src","${path}"+data);
                    $("#img").show();
                    $("#pic").val(data);
                }
            });
        });

        $("#name").blur(checkrealName);
        $("#phone").blur(checkPhone);
        // $("#username").blur(checkName);

        $("#submit").click(function (){
            checkPhone();
            // checkName();
            checkrealName();
            if(nameflag==false||phoneflag==false||realnameflag==false){
                return false;
            }
        })

    });

    function checkName(){
        var username = $("#username").val();
        var usernameExp = /^\w{5,15}$/;
        if(!usernameExp.test(username)){
            $("#usernameMsg").html("用户名格式错误，请输入5-15位数字字母下划线");
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
                        nameflag=false;
                    }
                }

            });
        }
    }

    function checkrealName(){
        var name = $("#name").val();
        var nameExp = /^[\u4e00-\u9fa5]{2,7}$/;
        if(!nameExp.test(name)){
            $("#nameMsg").html("名字格式错误，请输入2-7位中文");
            $("#nameMsg").css("color","red");
            realnameflag = false;
        }
        else{
            $("#nameMsg").html("√");
            $("#nameMsg").css("color","green");
            realnameflag=true;
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


</script>