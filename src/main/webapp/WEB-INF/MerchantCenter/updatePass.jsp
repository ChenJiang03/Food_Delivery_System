
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="author" content="order by dede58.com"/>
    <title>商家注册</title>
    <meta name="keywords" content="DeathGhost,DeathGhost.cn,web前端设,移动WebApp开发" />
    <meta name="description" content="DeathGhost.cn::H5 WEB前端设计开发!" />
    <meta name="author" content="DeathGhost"/>
    <link href="${path}/webConfig/style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${path}/webConfig/js/public.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jqpublic.js"></script>
    <script type="text/javascript" src="${path}/webConfig/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        $(function (){
            var co=false;
            var oldPass=${sessionScope.merchant.password};
            var a=false;
            var pass=false;
            var confirmPass=false

            //验证旧密码
                $("#oldPass").blur(function (){
                    if (oldPass==$("#oldPass").val()){
                        $("#oldPass1").html("✔")
                        a=true;
                    }
                    else {
                        $("#oldPass1").html("密码错误")
                        a=false;
                    }
                });

            //新密码验证
            $("#password").blur(function (){
                var val1=/^\w{5,20}$/;
                var val2=$("#password").val();
                if (!val1.test(val2)){
                    $("#password1").html("请输入5-20位数字、字母、下划线");
                    pass=false;
                }
                else{
                    $("#password1").html("✔");
                    pass=true;
                }
            });

            //确认密码
            $("#ConfirmPass").blur(function (){
                var val1=$("#ConfirmPass").val();
                var val2=$("#password").val();
                if (val1!=val2){
                    $("#ConfirmPass1").html("两次密码不一致");
                    confirmPass=false;
                }
                else if(val2==""){
                    $("#ConfirmPass1").html("请确认密码");
                    confirmPass=false;
                }
                else {
                    $("#ConfirmPass1").html("✔");
                    confirmPass=true;
                }
            });


            //验证码
            $("#code").blur(function (){
               var code=$(this).val();
                $.ajax({
                    url:"${path}/Code/checkCode",
                    type:"post",
                    data:{code:code},
                    success:function (data) {
                        if(data=="ok"){
                            $("#code1").html("√");
                            co=true;
                        }
                        else{
                            $("#code1").html("验证码错误");
                            co=false;
                        }
                    }
                })
            });


            $("#tijiao").click(function (){
                if (a==false||co==false||pass==false||confirmPass==false){
                    return false;
                }
            });




        });
    </script>
</head>
<body>
<jsp:include page="/webConfig/inc/merchantTop.jsp"></jsp:include>
<!--Start content-->
<section class="Psection MT20">
    <form action="${path}/MerchantCenter/updatePass" id="myform" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${sessionScope.merchant.id}" name="id">
        <table class="Register">
            <tr>
                <td width="40%" align="right" class="FontW">*原密码：</td>
                <td><input type="password" name="oldPass" id="oldPass"><span id="oldPass1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*新密码：</td>
                <td><input type="password" name="password" id="password"><span id="password1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*确认密码：</td>
                <td><input type="password" name="ConfirmPass" id="ConfirmPass"><span id="ConfirmPass1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right" class="FontW">*验证码：</td>
                <td><input type="text" name="code" id="code" required><img src="${path}/Code/getCode" style="margin-left:8px; vertical-align:bottom" width="83" height="36"><span id="code1"></span></td>
            </tr>
            <tr>
                <td width="40%" align="right"></td>
                <td><input type="submit" name="tijiao" id="tijiao" class="Submit_b" value="提交"></td>
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
